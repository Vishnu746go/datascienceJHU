# Question: 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
library(dplyr)

# reading data
National_emmissions_inventory <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")

# selecting two columns Emissions and year
final <- National_emmissions_inventory %>%
  select(Emissions, year) %>%
  # grouping data by year column
  group_by(year) %>%
  mutate(year = factor(year)) %>%
  summarize(total_emissions = sum(Emissions))

# Display the barplot directly in the R graphics window
barplot(
  final$total_emissions,
  names.arg = final$year,
  xlab = "Years",
  ylab = "Emissions",
  main = "Emissions analysis"
)
# ANOTHER WAY(METHOD)
# Load necessary libraries
library(dplyr)

# Reading the data
National_emissions_inventory <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")

# Filter data for the years 1999, 2002, 2005, and 2008
filtered_data <- National_emissions_inventory %>%
  filter(year %in% c(1999, 2002, 2005, 2008))

# Group the data by year and calculate the total PM2.5 emissions for each year
total_emissions <- filtered_data %>%
  group_by(year) %>%
  summarise(total_PM25_emissions = sum(Emissions))

# Create a bar plot using base R plotting system
barplot(
  total_emissions$total_PM25_emissions,
  names.arg = total_emissions$year,
  xlab = "Years",
  ylab = "Total PM2.5 Emissions",
  main = "Total PM2.5 Emissions in the United States (1999-2008)"
)
