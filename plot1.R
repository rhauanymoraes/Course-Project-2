#Author: Rhauany Catharine Moraes

setwd("C:/Users/rhauany.moraes/Desktop/Curso R")
require(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 

emissions <- summarise(group_by(NEI, year), Emissions=sum(Emissions))

png("plot1.png", width = 480, height = 480)
with(emissions, barplot(Emissions/1000, year, col = c("red","orange","yellow","blue"),ylim=c(0,8000), 
                        names.arg=year, xlab = "years", 
                        ylab=expression('total PM'[2.5]*' emission in kilotons'),
                        main=expression('Total PM'[2.5]*' emissions at various years in kilotons')))
dev.off()
