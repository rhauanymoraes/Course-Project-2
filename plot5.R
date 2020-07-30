#Author: Rhauany Catharine Moraes

setwd("C:/Users/rhauany.moraes/Desktop/Curso R")
require(dplyr)
require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

baltimore_vehicle <- filter(emissions_baltimore_type, type == "ON-ROAD")

png("plot5.png", width = 480, height = 480)
ggplot(data = baltimore_vehicle, aes(factor(year), Emissions, fill = year)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label=round(Emissions,1)),vjust=-0.4,angle=0,hjust=.5, size=4.5) +
  theme_minimal(base_size = 15) +
  theme(line=element_blank(),
        panel.background = element_blank()) +
  labs(x = "year", y = expression('total PM'[2.5]*' emission'), 
       title = "Emissions from motor vehicle sources in Baltimore")
dev.off()
