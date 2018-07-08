##Plot 5 to answer the question:
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

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

# Filter data on names containing "vehicles" or "Vehicles"
vehicle_data <- SCC[grep("*vehicle*|*Vehicle*",SCC$Short.Name),]$SCC
head(vehicle_data)

# Filter vehicle data on Baltimore City using provided city code
baltimoreCity <- subset(NEI, fips == "24510")
baltimoreV <- baltimoreCity[baltimoreCity$SCC %in% vehicle_data,]
head(baltimoreV)

# Aggregate vehicle data by mean Emissions
baltimoreVMean <- aggregate(baltimoreV$Emissions, list(baltimoreV$year),mean)
colnames(baltimoreVMean) <- c("Year", "Vehicle_Emissions")
str(baltimoreVMean)
summary(baltimoreVMean)
head(baltimoreVMean)

# Plot to PNG file
png("plot5.png", width = 640, height = 640)
ggplot(baltimoreVMean, aes(x=Year, y=Vehicle_Emissions)) + xlab("Year") + ylab("Vehicle-related Emissions") + geom_line() + geom_point(aes(color=Year)) + ggtitle("Baltimore Yearly Mean Vehicular Emissions, 1999-2008")
dev.off()