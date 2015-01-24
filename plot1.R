#Load library
library(plyr)



## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



#create png file
png(filename = "plot1.png", width = 480, height = 480, units = "px")

#plot the graph
with( ddply(NEI,.(year),summarize, totalPM2.5=sum(Emissions)), plot(year, totalPM2.5, type='l'))

#close device
dev.off()


