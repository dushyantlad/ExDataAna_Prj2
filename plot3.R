#Load library
library(plyr)



## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



#create png file
png(filename = "plot3.png", width = 480, height = 480, units = "px")

#plot the graph
plot3 <- ggplot(ddply(filter(NEI, fips=="24510"),.(year,type),summarize, Emissions=sum(Emissions) )  )
plot3 <- plot3+ geom_line(aes(year,Emissions,color=type))
print(plot3)

#close device
dev.off()
