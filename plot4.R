# Question 4: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# Core files (.rds files) were unzipped and placed in my working directory.

# Load the required packages
library(dplyr)
library(data.table)
library(ggplot2)

# Read the core files using base function readRDS.

 NEI <- readRDS("summarySCC_PM25.rds")
 SCC <- readRDS("Source_Classification_Code.rds")
 
# Subset coal combustion related NEI data

combustion_Aspect <- grepl("comb", SCC$SCC.Level.One, ignore.case = TRUE)
coal_Aspect <- grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE) 
coal_Combustion <- (combustion_Aspect & coal_Aspect)
combustion_SCC <- SCC[coal_Combustion,]$SCC
combustion_NEI <- NEI[NEI$SCC %in% combustion_SCC,]

# Create and export a PNG file

png("plot4.png")

gp <- ggplot(combustion_NEI, aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity", fill="green", width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

print(gp)

dev.off()

# Answer: Across the States, emissions from coal combustion-relates sources have decreased from 1999-2008, notably between 2005 and 2008.
