#Author: Rhauany Catharine Moraes

setwd("C:/Users/rhauany.moraes/Desktop/Curso R")
require(dplyr)
require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

combustion.coal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
combustion.coal.sources <- SCC[combustion.coal,]
emissions.coal.combustion <- NEI[(NEI$SCC %in% combustion.coal.sources$SCC), ]

combustion <- summarise(group_by(emissions.coal.combustion,year), Emissions=sum(Emissions))

png("plot4.png", width = 540, height = 480)
ggplot(data = combustion, aes(factor(year), Emissions/1000, fill = year)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label=round(Emissions/1000,1)),vjust=-0.4,angle=0,hjust=.5, size=4.5) +
  theme_minimal(base_size = 15) +
  theme(line=element_blank(),
        panel.background = element_blank()) +
  labs(x = "year", y = expression('total PM'[2.5]*' emission in kilotons'), 
       title = "Emissions from coal combustion-related sources in kilotons")
dev.off()
