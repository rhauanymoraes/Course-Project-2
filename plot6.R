#Author: Rhauany Catharine Moraes

setwd("C:/Users/rhauany.moraes/Desktop/Curso R")
require(dplyr)
require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

bal_la <- filter(NEI, fips == "24510" | fips == "06037")
emissions_bal_la_type <- summarise(group_by(bal_la,fips,type,year), Emissions=sum(Emissions))
emission_bal_la_vehicle <- filter(emissions_bal_la_type, type == "ON-ROAD")

emission_bal_la_vehicle$county <- c(rep("Los Angeles",4), rep("Baltimore",4))

png("plot6.png", width = 960, height = 480)
ggplot(data = emission_bal_la_vehicle, aes(factor(year), Emissions, fill = county)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label=round(Emissions,1)),vjust=-0.4,angle=0,hjust=.5, size=4.5) +
  facet_grid(.~county)+
  theme_minimal(base_size = 18) +
  theme(line=element_blank(),
        panel.background = element_blank()) +
  labs(x = "year", y = expression('total PM'[2.5]*' emission'), 
       title = "Emissions from motor vehicle sources in Baltimore and Los Angeles")
dev.off()


