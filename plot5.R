#Load library
library(plyr)



## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



#create png file
png(filename = "plot5.png", width = 480, height = 480, units = "px")

#plot the graph
baltimore_df = ddply(filter(NEI, fips=="24510"),.(year,SCC),summarize, Emissions=sum(Emissions))
mv_df = SCC[grep('[mM]otor',SCC$Short.Name),c('SCC','Short.Name')]
data_df= merge(baltimore_df, mv_df, by='SCC')

plot5 <- ggplot(ddply(data_df, .(year),summarize,Emissions=sum(Emissions)) )
plot5 <- plot5 + geom_line(aes(year,Emissions))
print(plot5)

#close device
dev.off()
