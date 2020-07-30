#Author: Rhauany Catharine Moraes

setwd("C:/Users/rhauany.moraes/Desktop/Curso R")
require(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable 
#which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008? 

emissions_baltimore_type <- summarise(group_by(baltimore, type,year), Emissions=sum(Emissions))
require(ggplot2)

png("plot3.png", width = 960, height = 480)
ggplot(data = emissions_baltimore_type, aes(factor(year), Emissions, fill = type)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label=round(Emissions,1)),vjust=-0.4,angle=0,hjust=.5, size=4) +
  facet_grid(.~type) +
  theme_minimal(base_size = 18) +
  theme(line=element_blank(),
        panel.background = element_blank()) +
  labs(x = "year", y = expression('total PM'[2.5]*' emission'), 
       title = expression('Total PM'[2.5]*' emissions in Baltimore City-MD'))
dev.off()
