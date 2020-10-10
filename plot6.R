# Question 6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (\color{red}{\verb|fips == "06037"|}fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# Core files (.rds files) were unzipped and placed in my working directory.

# Load the required packages
library(dplyr)
library(data.table)
library(ggplot2)

# Read the core files using base function readRDS.

 NEI <- readRDS("summarySCC_PM25.rds")
 SCC <- readRDS("Source_Classification_Code.rds")
 
 # Gather the subset of the NEI data which corresponds to vehicles

vehicles <- grepl(pattern = "vehicle",x = SCC$SCC.Level.Two,ignore.case = TRUE)
vehicles_SCC <- SCC[vehicles,]$SCC
vehicles_NEI <- NEI[NEI$SCC %in% vehicles_SCC,]

# Subset the vehicles NEI data by each city's fip and add city name.

vehicles_Baltimore_NEI <- (vehicles_NEI[vehicles_NEI$fips == "24510" | vehicles_NEI$fips == "06037",])
vehicles_Baltimore_NEI[,1] <- as.factor(x = vehicles_Baltimore_NEI[,1])

vehicles_Baltimore_NEI <- vehicles_Baltimore_NEI
levels(vehicles_Baltimore_NEI$fips)[levels(vehicles_Baltimore_NEI$fips)=="06037"] <- "Los Angeles"
levels(vehicles_Baltimore_NEI$fips)[levels(vehicles_Baltimore_NEI$fips)=="24510"] <- "Baltimore City"


# Create and export a PNG file

png("plot6.png")

gp <- ggplot(data = vehicles_Baltimore_NEI, aes(factor(year), Emissions)) +
        geom_bar(stat = "identity",fill = "green", width = 0.75) + 
        facet_grid(facets = .~fips,scales = "free", space = "free") +
        theme_grey(base_size = 14,base_family = "") +
        labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
        labs(title=expression("PM"[2.5]*" Vehicle Emissions, LA County and Baltimore"))

print(gp)

dev.off()

# Answer: Plot6 graph clearly indicates that motor vehicle emissions have gone up in Los Angeles whereas they have declined in Baltimore City.
