# Question: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == "24510"|}fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question 

# Core files (.rds files) were unzipped and placed in my working directory.

# Load the required packages

library(dplyr)
library(data.table)

# Read the core files using base function readRDS.

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Collect the needed sample using sum of the Baltimore emissions data by year

baltimore_Info <- NEI[NEI$fips=="24510",]
sum_Total_Baltimore <- aggregate(Emissions ~ year, baltimore_Info, sum)

# Create and export the corresponding PNG file

png(filename='plot2.png')

barplot(sum_Total_Baltimore$Emissions,
names.arg = sum_Total_Baltimore$year,
col = "green",
xlab = "Year",
ylab = expression("Total Tons of PM"[2.5]*" Emissions"),
main = "Total PM2.5 Emissions in Baltimore"
)

dev.off()

# Answer: Yes, as one can deduce from plot2, there is a noticeable decline from the year 1999 to the year 2008 in total PM2.5 emissions in Baltimore City; although, the period between 2002 and 2005 shows an upward trend. 
