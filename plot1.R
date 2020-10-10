# Core files (.rds files) were unzipped and placed in my working directory.

# Load the required packages

library(dplyr)
library(data.table)

# Read the core files using base function readRDS.

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Tabulate the emissions per year

sum_Total <- aggregate(Emissions ~ year,NEI, sum)

# Create and export the corresponding PNG file

png(filename = 'plot1.png')

barplot(
(sum_Total$Emissions)/10^6,
names.arg = sum_Total$year,
col = "green",
xlab = "Year",
ylab = "PM2.5 Emissions (10^6 Tons)",
main = "Total PM2.5 Emissions under review"
)

dev.off()
