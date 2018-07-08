## Plot 1 to answer the question:
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?

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

# Summing emissions data from all years
totalEmissions <- aggregate(Emissions ~ year,NEI, sum)

# Plot to PNG file
png("plot1.png", width = 640, height = 640)
barplot(totalEmissions$Emissions, xlab="Year", ylab="PM2.5 Emissions", main = "Yearly Total PM2.5 Emissions, 1999-2008", names.arg = totalEmissions$year, col="cyan")
dev.off()