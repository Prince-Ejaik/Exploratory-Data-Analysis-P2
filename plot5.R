# Question 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Core files (.rds files) were unzipped and placed in my working directory.

# Load the required packages
library(dplyr)
library(data.table)
library(ggplot2)

# Read the core files using base function readRDS.

 NEI <- readRDS("summarySCC_PM25.rds")
 SCC <- readRDS("Source_Classification_Code.rds")
 
 # Filter SCC dataset for vehicle entries

vehicles <- grepl(pattern = "vehicle",x = SCC$SCC.Level.Two,ignore.case = TRUE)
vehicles_SCC <- SCC[vehicles,]$SCC
vehicles_NEI <- NEI[NEI$SCC %in% vehicles_SCC,]

baltimore_vehicles_NEI <- (vehicles_NEI[vehicles_NEI$fips == "24510",])

# Create and export the corresponding PNG file

png(filename = "plot5.png")

gp <- ggplot(data = baltimore_vehicles_NEI, aes(factor(year), Emissions)) +
        geom_bar(stat = "identity",fill = "green", width = 0.75) +
        theme_grey(base_size = 14,base_family = "") +
        labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
        labs(title=expression("PM"[2.5]*" Vehicle Source Emissions, Baltimore City"))

print(gp)

dev.off()

# Answer: Emissions from motor vehicle sources have experienced a downward trend in Baltimore City in the period under review.
