# Question 6:Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (
#fips == "06037"
#fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
# Load necessary libraries
library(dplyr)
library(ggplot2)
library(stringr)

# Read the NEI and SCC data
NEI_data <- readRDS("EDA IN R/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC_data <- readRDS("EDA IN R/exdata_data_NEI_data/Source_Classification_Code.rds")

# Filter SCC data for vehicle-related sources
vehicleSCC <- SCC_data %>%
  filter(str_detect(SCC.Level.Two, "[Vv]ehicle"))

# Filter NEI data for vehicle-related SCCs
vehicleNEI <- NEI_data %>%
  filter(SCC %in% vehicleSCC$SCC)

# Filter NEI data for Baltimore City (fips == "24510")
balt_vehicleNEI <- vehicleNEI %>%
  filter(fips == "24510")

# Filter NEI data for Los Angeles County (fips == "06037")
la_vehicleNEI <- vehicleNEI %>%
  filter(fips == "06037")

# Create a ggplot2 line plot to compare emissions over time
ggplot() +
  geom_line(data = balt_vehicleNEI, aes(x = year, y = Emissions, color = "Baltimore City")) +
  geom_line(data = la_vehicleNEI, aes(x = year, y = Emissions, color = "Los Angeles County")) +
  theme_bw(base_family = "Helvetica") +
  labs(
    x = "Year",
    y = "Total Emissions",
    title = "Comparison of Motor Vehicle Emissions between Baltimore City and Los Angeles County"
  ) +
  scale_color_manual(values = c("Baltimore City" = "blue", "Los Angeles County" = "red"))
