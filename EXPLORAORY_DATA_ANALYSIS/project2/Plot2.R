# Question 2:2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Reading the data
National_emissions_inventory <- readRDS("C:/Users/vishn/Downloads/mydownloads/EDA IN R/exdata_data_NEI_data/summarySCC_PM25.rds")

# Filter data for Baltimore City (fips == "24510") and the years 1999 to 2008
balt <- subset(National_emissions_inventory, fips == "24510" & year >= 1999 & year <= 2008)

# Calculate total PM2.5 emissions for each year
total_emissions <- aggregate(Emissions ~ year, data = balt, FUN = sum)

# Create a bar plot using base R plotting system
barplot(
  total_emissions$Emissions,
  names.arg = total_emissions$year,
  xlab = "Years",
  ylab = "Emissions",
  main = "Total Emissions in Baltimore City from 1999 to 2008"
)

