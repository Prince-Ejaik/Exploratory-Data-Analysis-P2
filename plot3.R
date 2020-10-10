# Questions: Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

# Core files (.rds files) were unzipped and placed in my working directory.

# Load the required packages
library(dplyr)
library(data.table)
library(ggplot2)

# Read the core files using base function readRDS.

 NEI <- readRDS("summarySCC_PM25.rds")
 SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI data by Baltimore

 baltimore_NEI <- (NEI[NEI$fips == "24510",])
 sum_Total_Baltimore <- aggregate(Emissions ~ year, baltimore_NEI,sum)

# Create and export the corresponding PNG file
 
png("plot3.png")

 gp <- ggplot(baltimore_NEI,aes(factor(year),Emissions,fill=type)) +
    geom_bar(stat="identity") +
     theme_bw() + guides(fill=FALSE)+
    facet_grid(.~type,scales = "free",space="free") + 
    labs(x = "Year", y = expression("Total PM"[2.5]*" Emission (Tons)")) + 
    labs(title = expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

print(gp)

dev.off()

# Answer: On the one hand, on-road, non-road, and non-point sources have respectively witnessed a decline in PM2.5 emissions from 1999-2008. 
# On the other hand, point sources have seen an increase over the same time period (with the exception of 2008).
