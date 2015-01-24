#Load library
library(plyr)



## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



#create png file
png(filename = "plot4.png", width = 480, height = 480, units = "px")

#plot the graph
emission_df = ddply(NEI,.(year,SCC),summarize, Emissions=sum(Emissions))
coal_df = SCC[grep('[cC]oal',SCC$Short.Name),c('SCC','Short.Name')]
data_df= merge(emission_df, coal_df, by='SCC')

plot4 <- ggplot(ddply(data_df, .(year),summarize,Emissions=sum(Emissions)) )
plot4 <- plot4 + geom_line(aes(year,Emissions))
print(plot4)

#close device
dev.off()
