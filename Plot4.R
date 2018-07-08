## Plot 4 to answer the question:
## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

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

# Filter data on names containing "Coal" or "coal"
SCCcoal <- SCC[grep("*coal*|*Coal*",SCC$Short.Name),]$SCC
coalData <- NEI[NEI$SCC %in% SCCcoal,]
str(coalData)
summary(coalData)
head(coalData)

# Aggregate data relating to coal emissions
coalTotal <- with(coalData, aggregate(Emissions, by = list(year), sum))
colnames(coalTotal) <- c("Year", "Coal_Emissions")
str(coalTotal)
summary(coalTotal)
head(coalTotal)

# Plot to file
png("plot4.png", width = 640, height = 640)
ggplot(coalTotal, aes(x=Year, y=Coal_Emissions)) + xlab("Year") + ylab("Coal Combustion-related Emissions") + geom_line() + geom_point(aes(color=Year), size=3) + ggtitle("US Yearly PM2.5 Emissions by Coal Combustion, 1999-2008")
dev.off()