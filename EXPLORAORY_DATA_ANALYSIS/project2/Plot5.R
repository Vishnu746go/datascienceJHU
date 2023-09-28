# question 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
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

# Create a ggplot2 bar plot
ggplot(balt_vehicleNEI, aes(factor(year), Emissions)) +
  geom_bar(stat = "identity") +
  theme_bw(base_family = "Helvetica") +
  labs(
    x = "Years",
    y = "Total Emissions",
    title = "Motor Vehicle Sources Emissions in Baltimore City (1999 to 2008)"
  )

