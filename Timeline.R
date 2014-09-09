#Plot a timeline
library(ggplot2)
library(RCurl)#need this package to read csv from git hub 

TimelineURL<-getURL("https://raw.githubusercontent.com/Monsauce/Descience/master/Timeline.csv")
Timeline<-read.csv(text=TimelineURL)

p<-ggplot(Timeline, aes(x=factor(Year), y=0, label=Species))+ #add data by year 
  geom_hline(y=0,size=2,color='grey')+ #adds grey segment along y=0
  geom_point(aes(size=Duration, colour=Classification))+ #scale size of points by duration of study 
  geom_text(size=3,hjust=1,angle = 90, family="Helvetica", fontface="bold",colour="black")+ #add labels and change font
  scale_size_continuous(range = c(6, 30))+ #sets the max and min size of scaled points otherwise they would be too small
  theme(axis.text.x=element_text(size=12, colour="black",family="Helvetica", face="bold"))+ #adjust size and font of year labels
  theme(legend.position="none")+ #removes gridlines, axes, plotting background
  theme(axis.ticks.x=element_blank())+
  theme(axis.text.y = element_blank())+
  theme(axis.ticks = element_blank())+
  theme(axis.title.x = element_blank())+
  theme(axis.title.y = element_blank())+
  theme(panel.grid.major = element_blank())+
  theme(panel.grid.minor = element_blank())+
  theme(panel.background = element_rect(fill = "white"))+
  scale_colour_manual(values=c("#b30303","#31313d")) #set colours for "Classification" 

print(p)
