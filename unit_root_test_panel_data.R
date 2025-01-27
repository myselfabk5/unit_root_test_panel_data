library(plm) 
library(urca)
library(readxl)
library(openxlsx)
setwd("C:/Users/DELL/OneDrive/ABCD-Study Materials/research_collab/final_processed_data/final")

############################################################################################################################################
exo_ = c("none", "intercept", "trend") # exogenous terms to consider
test_ = c("levinlin", "ips", "madwu", "Pm", "invnormal", "logit", "hadri") # name of all the tests
variables = c("Urate.Male.","Urate.female.","Urate.total.") # variables for which tests to be conducted
regions = c('Central Asia', 'West Asia', 'East Asia','South Asia') # regions for which tests to be conducted
################################################################################################################################################

# function to conduct all the above mentioned tests
# This function conducts the tests and saves the final file at the working directory that is set using setwd() command above
# I is a parameter that is either 0 or 1, if 0 it does not first difference the series, if 1 it does the first differencing of the series and then
# conducts all the tests. Default value of I is 0.
conducting_tests = function(exo_, test_, pdata, variables,region,I){
  wb = createWorkbook()
  for (tes in test_){
    addWorksheet(wb, paste0("test-", tes))
    dataframe = data.frame()
    for (var in variables) {
      for (ex in exo_){
        if (!(((tes == 'ips')|(tes == 'hadri')) & (ex == 'none'))){
          
          if (I==0){
            model_data = pdata[[var]]
          }else{
            model_data = diff(pdata[[var]], lag = 1)
          }
         levinlin_test = purtest(model_data,exo = ex, test = tes, pmax = 4) # as a rule of thumb, pmax is selected as square root of sample size for each i
         levinlin_test_stat = levinlin_test$statistic
         stat_lev = round(levinlin_test_stat$statistic,4)
         pvalue_lev = round(levinlin_test_stat$p.value,4)
         one_row = data.frame(Variable_name = var, test_type = ex, test_statistic = stat_lev, p_value = pvalue_lev)
         dataframe = rbind(dataframe, one_row)
        }else{
          
        }
    }
    }
    writeData(wb, paste0("test-", tes), dataframe)
  }
  saveWorkbook(wb, paste0(region,"_I-",I,"_first_generation_panel_unit_root_test_results.xlsx"), overwrite = TRUE)
}


conducting_test_across_regions = function(exo_, test_, variables,regions, filename,I=0){
  for (reg in regions){
    data = read_excel(filename, sheet = reg)
    df = data
    pdata = pdata.frame(df, index = c("country", "year"))
    conducting_tests(exo_=exo_, test_=test_, pdata=pdata, variables=variables,region=reg,I=I)
  }
}

# In this function name of the file is the input data file that must be present at the working directory
conducting_test_across_regions(exo_, test_, variables,regions, filename="input_data/final_data_all_regions_19_01_2025.xlsx",I=0) # set I = 0 or 1

