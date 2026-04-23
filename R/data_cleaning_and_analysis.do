****************************************************
* DECDI Data Analysis Project - Stata Version
* Author: Danielle KENGNE NGUEKO
* Purpose: Data cleaning + OLS + Panel regression
****************************************************

* ---------------------------------------
* 1. Clear memory and setup environment
* ---------------------------------------
clear all                          // Remove all existing data in memory
set more off                       // Prevent pause in output display
* ---------------------------------------
* 2. Dowload dataset (World Bank data)
* ---------------------------------------
ssc install wbopendata
wbopendata, indicator(NY.GDP.PCAP.CD SL.UEM.TOTL.ZS) clear  // Dowload dataset (World Bank data)
* ---------------------------------------
* 3. Inspect dataset
* ---------------------------------------
describe                           // Show variable structure
summarize                          // Show summary statistics
* ---------------------------------------
* 4. Data cleaning
* ---------------------------------------
drop if missing(gdp_per_capita)    // Remove missing GDP values
drop if missing(unemployment)      // Remove missing unemployment values

* Check cleaned data
summarize gdp_per_capita unemployment   // Re-check summary statistics
* ---------------------------------------
* 5. OLS Regression
* ---------------------------------------
reg gdp_per_capita unemployment     // Run simple linear regression

estimates store OLS                 // Save OLS results for comparison
* ---------------------------------------
* 6. Declare panel structure
* ---------------------------------------
xtset country year                  // Define panel: country = ID, year = time
* ---------------------------------------
* 7. Fixed Effects Panel Regression
* ---------------------------------------
xtreg gdp_per_capita unemployment, fe   // Fixed effects model (within estimator)
estimates store FE                 // Save FE model results
* ---------------------------------------
* 8. Compare models
* ---------------------------------------
esttab OLS FE, se star(* 0.10 ** 0.05 *** 0.01)   // Compare OLS vs FE estimates
* ---------------------------------------
* End of file
* ---------------------------------------
