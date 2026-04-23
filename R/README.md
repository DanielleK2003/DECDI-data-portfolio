# DECDI Data Analysis Portfolio (R)

**Author:** Danielle KENGNE NGUEKO  
**Role:** Economist | Statistician | Data Analyst | Financial Engineer  

**Project Overview**
This repository contains a reproducible data analysis project using World Bank Development Indicators. The objective is to apply econometric and data analysis techniques to explore macroeconomic relationships relevant to development policy, including unemployment and GDP per capita.
The project demonstrates skills in data extraction, cleaning, econometric modeling, and policy-oriented interpretation using R.
**Data Source**
The data is sourced from the World Bank Open Data API via the WDI R package. The dataset includes macroeconomic indicators such as:
GDP per capita
Unemployment rate
Population
The data covers multiple countries over the period 2015–2022, forming an unbalanced panel dataset.

**Tools and Technologies**
R
WDI
dplyr
ggplot2
plm (panel data econometrics)

**Methodology**
The analysis follows a structured pipeline:
1. Data extraction from World Bank API
2. Data cleaning and preprocessing
3. Descriptive statistical analysis
4. OLS regression analysis
5. Fixed effects panel regression
6. Interpretation of econometric results
7. Policy-oriented discussion of findings

# Linear Regression Results (OLS)
A simple ordinary least squares (OLS) regression was estimated using the model: gdp_per_capita ~ unemployment

Data Notes: 219 observations were excluded due to missing values.

# Model Output Summary:
The estimated coefficient for unemployment is -520.88, indicating a negative relationship with GDP per capita.
The intercept is 18,293.08.
The unemployment coefficient is statistically significant at the 1% level (p < 0.001).
The model has an R-squared of 0.020, indicating limited explanatory power.
The model is overall statistically significant (F-statistic = 37.78, p < 0.001).
Residual standard error: 19,430.

# Economic Interpretation
1. The regression results indicate a statistically significant negative relationship between unemployment and GDP per capita. Specifically, the estimated coefficient suggests that a one percentage point increase in unemployment is associated with a decrease of approximately 521 USD in GDP per capita, on average.
2. The relationship is statistically significant at the 1% level, confirming that the observed association is unlikely to be due to random variation. However, the model has a low explanatory power (R² = 0.02), indicating that unemployment alone explains only a small portion of the variation in GDP per capita across countries.
3. This suggests that GDP per capita is driven by multiple structural and macroeconomic factors not captured in this simple model. Therefore, the results should be interpreted as an association rather than a causal effect.
   
SUMMARY: While the baseline regression shows a statistically significant negative relationship between unemployment and GDP per capita, this specification is limited due to potential omitted variable bias.
A multiple regression framework is therefore more appropriate, allowing the inclusion of additional control variables such as population and structural characteristics. This improves the reliability of coefficient estimates by reducing confounding effects.
Furthermore, given the panel structure of the data, a fixed effects model (country and year) is recommended to control for unobserved heterogeneity and global shocks. Additional robustness checks, such as lagged variables and log transformations, can further strengthen the analysis and improve interpretability.

# Fixed Effects Panel Regression Results
The coefficient for unemployment is -402.30, indicating a negative relationship with GDP per capita within countries over time.
The estimate is statistically significant at the 1% level (p < 0.001).
The model includes 233 countries observed over 1 to 8 years, for a total of 1,850 observations (unbalanced panel).
The R-squared is 0.033, indicating low within explanatory power.
The model is globally statistically significant (F-statistic = 55.44, p < 0.001).
Data Notes: The panel is unbalanced, meaning not all countries have observations for all years.
Fixed effects control for both country-specific and time-specific unobserved heterogeneity.

# Interpretation 
1. The fixed effects (two-way within) panel regression estimates the relationship between unemployment and GDP per capita while controlling for both country-specific and time-specific unobserved heterogeneity.
2. The results show a statistically significant negative relationship between unemployment and GDP per capita. The coefficient of -402.30 suggests that, within a given country over time, a one percentage point increase in unemployment is associated with an average decrease of approximately 402 USD in GDP per capita, holding country and time effects constant.
3. The relationship is highly statistically significant (p < 0.001), indicating strong evidence of a negative association within countries over time.
4. However, the model explains a relatively small proportion of within-variation (R² = 0.033), suggesting that GDP per capita dynamics are influenced by multiple additional factors beyond unemployment.
5. The use of a two-way fixed effects specification strengthens the analysis by controlling for unobserved heterogeneity across countries (e.g., structural differences, institutions) and global shocks over time (e.g., financial crises, pandemics).

# Model Fit and Limitations
Both the OLS and fixed effects panel models exhibit relatively low R-squared values, which is common in macroeconomic and cross-country development data. This reflects the fact that GDP per capita is driven by a broad set of structural, institutional, and external factors not captured in a simple specification.

# Potential Improvements
To improve model fit and strengthen the robustness of the analysis, several extensions are recommended:
- Inclusion of additional control variables, such as investment rates, inflation, education attainment, and trade openness, to better capture key macroeconomic determinants of growth.
- Log transformation of GDP per capita, to improve model specification, reduce skewness, and allow for percentage-based interpretation.
- Incorporation of lagged explanatory variables, to account for delayed effects of unemployment on economic performance.
Use of interaction terms, to explore heterogeneous effects across income groups or regions.
- Robustness checks with clustered standard errors at the country level, to address potential serial correlation within panels.
- Alternative panel specifications, such as random effects or dynamic panel models, depending on assumptions regarding unobserved heterogeneity and persistence.

# Policy Implications
The findings from both the OLS and fixed effects panel models suggest a consistent negative association between unemployment and GDP per capita. While the relationship is statistically significant, the limited explanatory power of the models highlights that economic performance is driven by a broader set of structural and institutional factors.
From a policy perspective, this suggests that addressing unemployment alone may not be sufficient to drive sustained improvements in income levels. Instead, policies should adopt a more integrated approach that combines labor market interventions with structural reforms aimed at improving productivity, investment, education, and economic diversification.
The results also highlight the importance of country-specific contexts, as the fixed effects model shows that unobserved structural differences play a significant role in explaining economic outcomes. This implies that policy design should be tailored to country conditions rather than relying on uniform solutions.
Finally, the presence of time effects underscores the influence of global shocks on national economic performance, reinforcing the need for resilient macroeconomic frameworks capable of absorbing external volatility.

# Key Takeaway
This project demonstrates the application of econometric tools to real-world development data, highlighting both statistical relationships and their policy relevance. The analysis emphasizes the importance of robust modeling approaches in understanding macroeconomic dynamics.


NB: the code for the same work in STATA will be provide
