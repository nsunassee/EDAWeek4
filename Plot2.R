##Plot 2 to answer the question:
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008?

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

# Total all emissions in Baltimore City, for the years 1999 to 2008
totalBaltimoreCity <- tapply(baltimoreCity$Emissions, baltimoreCity$year, sum)
summary(totalBaltimoreCity)

# Plot to PNG file
png("plot2.png", width = 640, height = 640)
barplot(totalBaltimoreCity, xlab="Year", ylab="PM2.5 Emissions", main="Baltimore City Yearly Total PM2.5 Emissions, 1999-2008", col="brown")
dev.off()