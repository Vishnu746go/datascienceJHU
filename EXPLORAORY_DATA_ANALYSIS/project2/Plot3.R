# question 3: Of the four types of sources indicated by the type(point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008?
# Install and load the ggplot2 package (if not already installed)
if (!require(ggplot2)) {
  install.packages("ggplot2")
  library(ggplot2)
}

# Filter data for Baltimore City (fips == "24510") and the years 1999 and 2008
balt_1999 <- subset(National_emissions_inventory, fips == "24510" & year == 1999)
balt_2008 <- subset(National_emissions_inventory, fips == "24510" & year == 2008)

# Calculate total emissions for each source type in 1999 and 2008
emissions_1999 <- aggregate(Emissions ~ type, data = balt_1999, FUN = sum)
emissions_2008 <- aggregate(Emissions ~ type, data = balt_2008, FUN = sum)

# Merge the two data frames to compare emissions for each source type
emissions_changes <- merge(emissions_1999, emissions_2008, by = "type")

# Calculate the changes in emissions
emissions_changes$emissions_change <- emissions_changes$Emissions.y - emissions_changes$Emissions.x

# Create a ggplot2 bar plot
ggplot(emissions_changes, aes(x = type, y = emissions_change, fill = emissions_change > 0)) +
  geom_bar(stat = "identity") +
  labs(
    x = "Source Type",
    y = "Change in Emissions",
    fill = "Increase (>0) or Decrease (<0)"
  ) +
  ggtitle("Changes in Emissions by Source Type (1999-2008)") +
  theme_minimal() +
  scale_fill_manual(values = c("Decrease" = "red", "Increase" = "green"))
