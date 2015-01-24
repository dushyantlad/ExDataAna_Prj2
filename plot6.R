#Load library
library(plyr)



## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



#create png file
png(filename = "plot6.png", width = 480, height = 480, units = "px")

#plot the graph
mv_df = SCC[grep('[mM]otor',SCC$Short.Name),c('SCC','Short.Name')]


bal_df = ddply(filter(NEI, fips=="24510"),.(fips,year,SCC),summarize, Emissions=sum(Emissions))
bal_data_df= merge(bal_df, mv_df, by='SCC')

la_df = ddply(filter(NEI, fips=="06037"),.(fips,year,SCC),summarize, Emissions=sum(Emissions))
la_data_df= merge(la_df, mv_df, by='SCC')

data_df= rbind(bal_data_df,la_data_df)


plot6 <- ggplot(ddply(data_df, .(fips,year),summarize,Emissions=sum(Emissions)) )
plot6 <- plot6 + geom_line(aes(year,Emissions,color=fips))
print(plot6)

#close device
dev.off()
