## Plot 3 to answer the questions:
## 1. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
## 2. Which have seen increases in emissions from 1999–2008? 

# Loading libraries
library(plyr)
library(ggplot2)

# Reading in and checking data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
dim(NEI)
str(NEI)
summary(NEI)
head(NEI)
dim(SCC)
str (SCC)
summary(SCC)
head(SCC)

# Subset data to Baltimore City using provided city code
baltimoreCity <- subset(NEI, fips == "24510")
dim(baltimoreCity)
str(baltimoreCity)
summary(baltimoreCity)
head(baltimoreCity)

# Total all types of emissions in Baltimore City, for the years 1999 to 2008
totalTypeBaltimoreCity <- ddply(baltimoreCity, .(year, type), function(x) sum(x$Emissions))
head(totalTypeBaltimoreCity)

# Plot to PNG file
png("plot3.png", width = 640, height = 640)
qplot(data=totalTypeBaltimoreCity, year, V1, color=type, geom=c("line","point")) + ggtitle("Baltimore City Yearly Total PM2.5 Emissions by Type, 1999-2008") + xlab("Year") + ylab("PM2.5 Emissions")
dev.off()