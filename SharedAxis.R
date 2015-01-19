#plot two horizontal bar charts wih a shared axis
library(plyr) #required packages
library(ggplot2)

####simulated data####

#no trolls data 
species<-rep(c("lion", "tiger", "bear"),each = 3)
plot<-c(1:3, 1:3, 1:3)
population<-c(rnorm(3,mean=15, sd=2),rnorm(3,mean=9, sd=2),rnorm(3,mean=30, sd=2))
OHMYNoTrolls<-data.frame(species,plot,population)
OHMYNoTrollsSum<-ddply(.data=OHMYNoTrolls, .variables=.(species), .fun= summarise, mean = mean(population), sd=sd(population))


#trolls present 
species<-rep(c("lion", "tiger", "bear"),each = 3)
plot<-c(1:3, 1:3, 1:3)
population<-c(rnorm(3,mean=9, sd=2),rnorm(3,mean=4, sd=2),rnorm(3,mean=22, sd=2))
OHMYTrolls<-data.frame(species,plot,population)
OHMYTrollsSum<-ddply(.data=OHMYTrolls, .variables=.(species), .fun= summarise, mean = mean(population), sd=sd(population))

####make horizontal bar charts####
NoTrollsPlot<- ggplot(data = OHMYNoTrollsSum, aes(x = species, y = mean, fill=species)) +
  geom_bar(stat = "identity") + 
  theme(axis.title.x = element_blank(), axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank(), panel.background = element_blank(),panel.grid.major = element_blank(), plot.margin = unit(c(1,-15,1,1), "mm"), legend.position="none") +#removes gridlines and legend so it only plots once on the next plot
  scale_y_reverse()+#changes the direction of your incremental scale on your x axis 
  coord_flip()+#flips your bar plot horizontally
  scale_fill_manual(values=c("#454545", "grey", "black"))+ #colours for fill of the bars
  geom_errorbar(aes(ymin=mean-sd, ymax=mean+sd),width=.2,position=position_dodge(.9))+
  ggtitle("No Trolls")


TrollsPlot<- ggplot(data = OHMYTrollsSum, aes(x = species, y = mean, fill=species)) +
  geom_bar(stat = "identity") + 
  theme(axis.title.x = element_blank(), axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank(), panel.background = element_blank(),panel.grid.major = element_blank(), plot.margin = unit(c(1,1,1,-15), "mm")) +
  coord_flip()+
  scale_fill_manual(values=c("#454545", "grey", "black"))+
  geom_errorbar(aes(ymin=mean-sd, ymax=mean+sd),width=.2,position=position_dodge(.9))+
  ggtitle("Trolls")+
  scale_y_continuous(limits=c(0, 30))#to make the x-axis symetrical with the last plot

#merge plots
SharedAxis<-arrangeGrob(NoTrollsPlot,TrollsPlot,ncol=2)#combine the two plots

print(SharedAxis)
