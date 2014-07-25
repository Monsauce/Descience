#icons in R 
install_github("devtools")
library(devtools)
install_github("sckott/rphylopic")
library(rphylopic) #install Rphylopic package 

#simulated data 
species<-rep(c("lion", "tiger", "bear"),each = 60)
day<-c(1:30, 1:30, 1:30)
population<-c(rnorm(30,mean=15, sd=2),rnorm(30,mean=9, sd=2),rnorm(30,mean=30, sd=2))
OHMY<-data.frame(species,day,population)

#get images 
lion <- get_image("e2015ba3-4f7e-4950-9bde-005e8678d77b", size = "512")[[1]]#lion image, "size" is the height pixel dimension
tiger <- get_image("e148eabb-f138-43c6-b1e4-5cda2180485a", size = "512")[[1]]#tiger image, "size" is the height pixel dimension
bear <- get_image("992a5a0c-f8dd-451f-b874-fcfc4aded21b", size = "512")[[1]]#bear image, "size" is the height pixel dimension

#plot 
library(ggplot2)#load graphing package 
require(gridExtra) #required to make grid plots 
lionplot<-ggplot(OHMY[1:60,], aes(x=day, y=population))+add_phylopic(lion)+theme_minimal()+geom_point()
tigerplot<-ggplot(OHMY[61:120,], aes(x=day, y=population))+add_phylopic(tiger)+theme_minimal()+geom_point()
bearplot<-ggplot(OHMY[121:180,], aes(x=day, y=population))+add_phylopic(bear)+theme_minimal()+geom_point()
OHMYPlot<-grid.arrange(lionplot, tigerplot, bearplot, ncol=3)


