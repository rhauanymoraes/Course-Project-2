#Author: Rhauany Catharine Moraes

setwd("C:/Users/rhauany.moraes/Desktop/Curso R")
require(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?

baltimore <- filter(NEI, fips == "24510")
emissions_baltimore <- summarise(group_by(baltimore, year), Emissions=sum(Emissions))

png("plot2.png", width = 480, height = 480)
with(emissions_baltimore, barplot(Emissions/1000, year, col = c("red","orange","yellow","blue"),
                        ylim=c(0,4), 
                        names.arg=year, xlab = "years", 
                        ylab=expression('total PM'[2.5]*' emission in kilotons'),
                        main=expression('Total PM'[2.5]*' emissions in Baltimore City-MD in kilotons')))
dev.off()
