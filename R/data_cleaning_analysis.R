# ============================================
# DECDI Data Task - Cleaning and Analysis
# Purpose: Data cleaning, analysis, and visualization
# Author: Danielle KENGNE NGUEKO
# ============================================
# -------------------------------
# 1. Install required packages and Load libraries
# -------------------------------
install.packages("WDI")
install.packages("dplyr")
install.packages("ggplot2")

library(WDI)      # To access World Bank Development Indicators API
library(dplyr)    # For data manipulation and cleaning
library(ggplot2)  # For data visualization

# -------------------------------
# 2. Define indicators of interest
# -------------------------------

# We select key macroeconomic indicators
indicators <- c(
  gdp_per_capita = "NY.GDP.PCAP.CD",   # GDP per capita (current USD)
  unemployment = "SL.UEM.TOTL.ZS",      # Unemployment rate (%)
  population = "SP.POP.TOTL"           # Total population
)

# -------------------------------
# 3. Download data from World Bank API
# -------------------------------
df <- WDI(
  country = "all",        # All countries included
  indicator = indicators, # Selected indicators
  start = 2015,          # Start year
  end = 2022             # End year
)

# -------------------------------
# 4. Inspect and prepare dataset
# -------------------------------
# View structure of dataset (useful for debugging)
str(df)

# -------------------------------
# 5. Clean the data
# -------------------------------

df_clean <- df %>%
  
  # Remove rows where GDP per capita is missing
  filter(!is.na(gdp_per_capita)) %>%
  
  # Rename variables for clarity
  mutate(
    region = country,  # Keep country name as region proxy
    year = year        # Ensure year is explicit
  )

# -------------------------------
# 6. Create summary statistics
# -------------------------------
# Compute average GDP per country across years
gdp_summary <- df_clean %>%
  
  group_by(region) %>%  # Group data by country
  
  summarise(
    avg_gdp = mean(gdp_per_capita, na.rm = TRUE)  # Average GDP
  ) %>%
  
  arrange(desc(avg_gdp))  # Sort from highest to lowest GDP

# -------------------------------
# 7. Select top 10 countries
# -------------------------------
top10 <- head(gdp_summary, 10)

# -------------------------------
# 8. Visualize results
# -------------------------------
ggplot(top10, aes(x = reorder(region, avg_gdp), y = avg_gdp)) +
  
  # Create bar chart
  geom_bar(stat = "identity") +
  
  # Flip coordinates for readability
  coord_flip() +
  
  # Add labels and title
  labs(
    title = "Top 10 Countries by Average GDP per Capita",
    x = "Country",
    y = "GDP per Capita (USD)"
  ) #here Moroco is the top one
# -------------------------------
# 9. Export cleaned dataset
# -------------------------------

write.csv(
  df_clean,
  "output/world_bank_cleaned.csv",
  row.names = FALSE
)
# -------------------------------
# 10. Export summary table
# -------------------------------

write.csv(
  gdp_summary,
  "output/gdp_summary.csv",
  row.names = FALSE
) 

# 9 and 10 will give and error because R will be trying to save a file inside a folder called output 
#but that folder might not exist in the working directory

# Ensure output directory exists for reproducibility
if (!dir.exists("output")) {
  dir.create("output")
} # this will fixe the previous error, so it has to be run before exporting the data
# one could place it at the begining of the code

# -------------------------------
# 11. Regression analysis: let's test whether unemployment is associated with GDP differences
# -------------------------------

# Simple linear regression:
# Does unemployment explain GDP per capita variation?

model <- lm(gdp_per_capita ~ unemployment, data = df_clean)

# Show regression results
summary(model)

# -------------------------------
# 12. panel regression
# -------------------------------
# Install panel data package installation and library
install.packages("plm")
library(plm)
  
 # -------------------------------
# Prepare panel structure
# -------------------------------

df_panel <- df_clean %>%
  
  # Keep only relevant variables
  select(country, year, gdp_per_capita, unemployment) %>%
  
  # Remove missing values for regression
  na.omit()
# Convert to panel data frame (country = individual unit; year = time dimension)
pdata <- pdata.frame(df_panel, index = c("country", "year"))

# -------------------------------
# Panel regression (Fixed Effects)
# -------------------------------

fe_model <- plm(
  gdp_per_capita ~ unemployment,
  data = pdata,
  model = "within",     # Fixed effects
  effect = "twoways"    # Country + Year effects
)

# Display results
summary(fe_model)

#Please find result and explanation in the readme
  
