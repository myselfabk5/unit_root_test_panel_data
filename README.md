# Panel Data Unit Root Testing: First Generation Tests
This repository provides R code for conducting first-generation panel unit root tests on panel data. The code implements several commonly used unit root tests for panel data, including Levin-Lin, IPS, Madwu, Pm, Invnormal, Logit, and Hadri tests. These tests can be used to assess the stationarity of panel data series, which is crucial for various types of panel data analysis.

Before running the code, make sure that you have the following R packages installed:

    plm: Provides functionality for working with panel data.
    urca: Contains functions for unit root tests.
    readxl: Used for reading Excel files.
    openxlsx: Used for writing results to Excel files.

To install the required packages, run the following commands in R:

install.packages("plm")

install.packages("urca")

install.packages("readxl")

install.packages("openxlsx")

## Input Data Format

The input data should be in an Excel file (e.g., final_data_all_regions_19_01_2025.xlsx) with the following structure:

    Sheet names: Each region should have its own sheet (e.g., "Central Asia", "West Asia", etc.). Each sheet represents a panel dataset for a specific region.
    Columns:
        Country: The country name or code.
        Year: The year of the data point.
        Variables: Time series variables (e.g., Urate.Male., Urate.Female., Urate.Total.) for which the tests will be performed.

## Code Explanation
1. Main Functions

    conducting_tests(exo_, test_, pdata, variables, region, I): This function conducts the selected unit root tests on the specified variables for a given region. It supports differencing the series if I = 1. The results are saved in an Excel workbook.

    conducting_test_across_regions(exo_, test_, variables, regions, filename, I = 0): This function runs the unit root tests for all specified regions. It reads data from the input Excel file (filename), processes each region's data, and then calls conducting_tests to perform the tests.

2. Parameters

    exo_: A vector specifying the exogenous terms to consider in the test. Possible values:
        "none": No exogenous term.
        "intercept": Includes an intercept in the model.
        "trend": Includes a time trend in the model.

    test_: A vector of test names. Available tests include:
        "levinlin": Levin-Lin test
        "ips": IPS test
        "madwu": Madwu test
        "Pm": Pm test
        "invnormal": Invnormal test
        "logit": Logit test
        "hadri": Hadri test

    variables: A vector of the variable names (e.g., "Urate.Male.", "Urate.Female.", "Urate.Total.") for which the tests should be conducted.

    regions: A vector of region names for which the tests will be conducted (e.g., "Central Asia", "West Asia").

    filename: The path to the input Excel file containing the panel data.

    I: Set to 1 to perform first differencing of the series before conducting the tests, or 0 to leave the series unchanged.

   The function will generate an Excel file in the current working directory with the results of the unit root tests for each region. The file is named as follows:
   [Region_Name]_I-[I]_first_generation_panel_unit_root_test_results.xlsx

   Each test (e.g., Levin-Lin, IPS) will have its own worksheet, and the results will include the following columns:

    Variable Name: The name of the variable tested.
    Test Type: The exogenous specification used in the test (e.g., "none", "intercept", "trend").
    Test Statistic: The computed test statistic.
    P-value: The p-value corresponding to the test statistic.

   ## How to Run

    Place the input Excel file (e.g., final_data_all_regions_19_01_2025.xlsx) in the input_data/ folder.
   
    Open R or RStudio.
   
    Set the working directory to the folder where the script and data are located using the following command:
   
   setwd("path/to/your/directory")


   The results will be saved in the current working directory as Excel files.





    
