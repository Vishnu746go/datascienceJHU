#question 4:Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
# Load necessary libraries
library(dplyr)
library(ggplot2)

# Read the NEI and SCC data
NEI_data <- readRDS("C:/Users/vishn/Downloads/mydownloads/EDA IN R/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC_data <- readRDS("C:/Users/vishn/Downloads/mydownloads/EDA IN R/exdata-data-NEI_data/Source_Classification_Code.rds")

# Filter SCC data for combustion-related and coal-related sources
combustionRelated <- grepl("comb", SCC_data$SCC.Level.One, ignore.case = TRUE)
coalRelated <- grepl("coal", SCC_data$SCC.Level.Four, ignore.case = TRUE)
combustionSCC <- SCC_data[combustionRelated & coalRelated, "SCC"]

# Subset NEI data for combustion-related SCCs
combustionNEI <- NEI_data[NEI_data$SCC %in% combustionSCC, ]

# Create a ggplot2 bar plot and display it
ggplot(combustionNEI, aes(x = factor(year), y = Emissions / 10^5)) +
  geom_bar(stat = "identity", fill = "#FF9999", width = 0.75) +
  labs(
    x = "Year",
    y = expression("Total PM"[2.5]*" Emission (10^5 Tons)"),
    title = expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008")
  )
