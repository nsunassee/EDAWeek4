##Plot 6 to answer the question:
## Which city between Baltimore City and LA County has seen greater changes over time in motor vehicle emissions?

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

# Filter vehicle data on LA County using provided city code
LACounty <- subset(NEI, fips == "06037")
LACountyV <- LACounty[LACounty$SCC %in% vehicle_data,]
head(LACountyV)

# Aggregate Baltimore City vehicle data by mean Emissions
baltimoreVMean <- aggregate(baltimoreV$Emissions, list(baltimoreV$year),mean)
baltimoreVMean$city <- rep("Baltimore",4)
colnames(baltimoreVMean) <- c("Year", "Vehicle_Emissions", "City")
str(baltimoreVMean)
summary(baltimoreVMean)
head(baltimoreVMean)

# Aggregate LA County vehicle data by mean Emissions
LACountyVMean <- aggregate(LACountyV$Emissions, list(LACountyV$year),mean)
LACountyVMean$city <- rep("LA County", 4)
colnames(LACountyVMean) <- c("Year", "Vehicle_Emissions", "City")
str(LACountyVMean)
summary(LACountyVMean)
head(LACountyVMean)

# Merge data from Baltimore City & LA County
citiesData <- rbind.data.frame(baltimoreVMean,LACountyVMean)

# Plot to PNG file
png("plot6.png", width = 640, height = 640)
ggplot(citiesData, aes(x=Year, y=Vehicle_Emissions, group=City)) + xlab("Year") + ylab("Vehicle-related Emissions") + geom_line(aes(color=City)) + geom_point(aes(color=City), size=3) + ggtitle("Baltimore vs LA County Yearly Mean Vehicular Emissions, 1999-2008")
dev.off()