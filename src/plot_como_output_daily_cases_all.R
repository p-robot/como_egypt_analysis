no_hosp_beds<-35152
no_icu_beds<-3539
no_ventilators<-2218
#prop_asymp<-0.8
#rep_asymp<-0.15
#rep_symp<-0.5

data_dir <- "data/output"

filename1<-file.path(data_dir, "outputs_Egypt_V13_facemask_low.csv")
filename2<-file.path(data_dir, "outputs_Egypt_V13_mod_adherence.csv")
filename3<-file.path(data_dir, "outputs_Egypt_V13_low_adherence.csv")
filename4<-file.path(data_dir, "outputs_Egypt_V13_facemask50.csv")
filename5<-file.path(data_dir, "outputs_Egypt_V13_facemask25.csv")
filename6<-file.path(data_dir, "outputs_Egypt_V13_unmitigated.csv")
filename7<-file.path(data_dir, "outputs-Egypt_V15_facemask25_AR11_NoMaskSep.csv")
filename8<-file.path(data_dir, "outputs-Egypt_V15_facemask25_AR11.csv")
  
#SHORT TERM
end_date1<-as.Date("2020-01-28")# End date for comparing results to observed cumulative deaths
end_date2<-as.Date("2020-08-15")# End date for future scenarios

#Base Case
como_output<-read.csv(filename1,header=T,colClasses=c(rep("character",126)))
como_output[,2:ncol(como_output)]<-as.numeric(as.matrix(como_output[,2:ncol(como_output)]))
como_output[,1]<-as.Date(como_output[,1])
ymax=2000000
xmin<-as.numeric(como_output[1,"date"]+1-como_output[1,"date"])
xmax<-as.numeric(end_date2+1-como_output[1,"date"])
df<-data.frame(seq(xmin,xmax),como_output[seq(xmin,xmax),"baseline_predicted_reported_and_unreported_med"],como_output[seq(xmin,xmax),"input_cases"],como_output[seq(xmin,xmax),"baseline_predicted_reported_med"])
names(df)<-c("index","pred_cases","obs_cases","pred_rep_cases")
p1<-ggplot(df,aes(x=index,y=pred_cases)) + geom_line(colour="blue") + geom_area(fill="cadetblue3") + 
  geom_line(aes(x=index,y=pred_rep_cases,colour="red3"),show.legend=F)+
  scale_x_continuous(breaks=seq(xmin,xmax,31),labels=como_output[seq(xmin,xmax,31),"date"]) + labs(x="Date",y="Daily total cases") + 
  ggtitle("High Ro - \nfinal attack rate = 12.5%")+theme(axis.text.x=element_text(angle=45,hjust=1,size=12),axis.text.y=element_text(size=12),axis.title=element_text(size=14),plot.title=element_text(hjust=0.5,size=14,face="bold"))+
  scale_y_continuous(breaks = seq(0,ymax, by = 10000))+ylim(0,ymax)


#Scenario 2
como_output<-read.csv(filename2,header=T,colClasses=c(rep("character",126)))
como_output[,2:ncol(como_output)]<-as.numeric(as.matrix(como_output[,2:ncol(como_output)]))
como_output[,1]<-as.Date(como_output[,1])
xmin<-as.numeric(como_output[1,"date"]+1-como_output[1,"date"])
xmax<-as.numeric(end_date2+1-como_output[1,"date"])
df<-data.frame(seq(xmin,xmax),como_output[seq(xmin,xmax),"baseline_predicted_reported_and_unreported_med"],como_output[seq(xmin,xmax),"input_cases"],como_output[seq(xmin,xmax),"baseline_predicted_reported_med"])
names(df)<-c("index","pred_cases","obs_cases","pred_rep_cases")
p2<-ggplot(df,aes(x=index,y=pred_cases)) + geom_line(colour="blue") + geom_area(fill="cadetblue3") + 
  geom_line(aes(x=index,y=pred_rep_cases,colour="red3"),show.legend=F)+
  scale_x_continuous(breaks=seq(xmin,xmax,31),labels=como_output[seq(xmin,xmax,31),"date"]) + labs(x="Date",y="Daily total cases") + 
  ggtitle("Moderate Ro - \nfinal attack rate = 11.7%")+theme(axis.text.x=element_text(angle=45,hjust=1,size=12),axis.text.y=element_text(size=12),axis.title=element_text(size=14),plot.title=element_text(hjust=0.5,size=14,face="bold"))+
  scale_y_continuous(breaks = seq(0,ymax, by = 10000))+ylim(0,ymax)


#Scenario 3
como_output<-read.csv(filename3,header=T,colClasses=c(rep("character",126)))
como_output[,2:ncol(como_output)]<-as.numeric(as.matrix(como_output[,2:ncol(como_output)]))
como_output[,1]<-as.Date(como_output[,1])
xmin<-as.numeric(como_output[1,"date"]+1-como_output[1,"date"])
xmax<-as.numeric(end_date2+1-como_output[1,"date"])
df<-data.frame(seq(xmin,xmax),como_output[seq(xmin,xmax),"baseline_predicted_reported_and_unreported_med"],como_output[seq(xmin,xmax),"input_cases"],como_output[seq(xmin,xmax),"baseline_predicted_reported_med"])
names(df)<-c("index","pred_cases","obs_cases","pred_rep_cases")
p3<-ggplot(df,aes(x=index,y=pred_cases)) + geom_line(colour="blue") + geom_area(fill="cadetblue3") + 
  geom_line(aes(x=index,y=pred_rep_cases,colour="red3"),show.legend=F)+
  scale_x_continuous(breaks=seq(xmin,xmax,31),labels=como_output[seq(xmin,xmax,31),"date"]) + labs(x="Date",y="Daily total cases") + 
  ggtitle("Low Ro - \nfinal attack rate = 11.8%")+theme(axis.text.x=element_text(angle=45,hjust=1,size=12),axis.text.y=element_text(size=12),axis.title=element_text(size=14),plot.title=element_text(hjust=0.5,size=14,face="bold"))+
  scale_y_continuous(breaks = seq(0,ymax, by = 10000))+ylim(0,ymax)

#Scenario 4
como_output<-read.csv(filename4,header=T,colClasses=c(rep("character",126)))
como_output[,2:ncol(como_output)]<-as.numeric(as.matrix(como_output[,2:ncol(como_output)]))
como_output[,1]<-as.Date(como_output[,1])
xmin<-as.numeric(como_output[1,"date"]+1-como_output[1,"date"])
xmax<-as.numeric(end_date2+1-como_output[1,"date"])
df<-data.frame(seq(xmin,xmax),como_output[seq(xmin,xmax),"baseline_predicted_reported_and_unreported_med"],como_output[seq(xmin,xmax),"input_cases"],como_output[seq(xmin,xmax),"baseline_predicted_reported_med"])
names(df)<-c("index","pred_cases","obs_cases","pred_rep_cases")
p4<-ggplot(df,aes(x=index,y=pred_cases)) + geom_line(colour="blue") + geom_area(fill="cadetblue3") + 
  geom_line(aes(x=index,y=pred_rep_cases,colour="red3"),show.legend=F)+
  scale_x_continuous(breaks=seq(xmin,xmax,31),labels=como_output[seq(xmin,xmax,31),"date"]) + labs(x="Date",y="Daily total cases") + 
  ggtitle("High Ro, high mask coverage - \nfinal attack rate = 7.6%")+theme(axis.text.x=element_text(angle=45,hjust=1,size=12),axis.text.y=element_text(size=12),axis.title=element_text(size=14),plot.title=element_text(hjust=0.5,size=14,face="bold"))+
  scale_y_continuous(breaks = seq(0,ymax, by = 10000))+ylim(0,ymax)

#Scenario 5
como_output<-read.csv(filename5,header=T,colClasses=c(rep("character",126)))
como_output[,2:ncol(como_output)]<-as.numeric(as.matrix(como_output[,2:ncol(como_output)]))
como_output[,1]<-as.Date(como_output[,1])
xmin<-as.numeric(como_output[1,"date"]+1-como_output[1,"date"])
xmax<-as.numeric(end_date2+1-como_output[1,"date"])
df<-data.frame(seq(xmin,xmax),como_output[seq(xmin,xmax),"baseline_predicted_reported_and_unreported_med"],como_output[seq(xmin,xmax),"input_cases"],como_output[seq(xmin,xmax),"baseline_predicted_reported_med"])
names(df)<-c("index","pred_cases","obs_cases","pred_rep_cases")
p5<-ggplot(df,aes(x=index,y=pred_cases)) + geom_line(colour="blue") + geom_area(fill="cadetblue3") + 
  geom_line(aes(x=index,y=pred_rep_cases,colour="red3"),show.legend=F)+
  scale_x_continuous(breaks=seq(xmin,xmax,31),labels=como_output[seq(xmin,xmax,31),"date"]) + labs(x="Date",y="Daily total cases") + 
  ggtitle("High Ro, moderate mask coverage - \nfinal attack rate = 10.3%")+theme(axis.text.x=element_text(angle=45,hjust=1,size=12),axis.text.y=element_text(size=12),axis.title=element_text(size=14),plot.title=element_text(hjust=0.5,size=14,face="bold"))+
  scale_y_continuous(breaks = seq(0,ymax, by = 10000))+ylim(0,ymax)

#Scenario 6
como_output<-read.csv(filename6,header=T,colClasses=c(rep("character",126)))
como_output[,2:ncol(como_output)]<-as.numeric(as.matrix(como_output[,2:ncol(como_output)]))
como_output[,1]<-as.Date(como_output[,1])
xmin<-as.numeric(como_output[1,"date"]+1-como_output[1,"date"])
xmax<-as.numeric(end_date2+1-como_output[1,"date"])
df<-data.frame(seq(xmin,xmax),como_output[seq(xmin,xmax),"baseline_predicted_reported_and_unreported_med"],como_output[seq(xmin,xmax),"input_cases"],como_output[seq(xmin,xmax),"baseline_predicted_reported_med"])
names(df)<-c("index","pred_cases","obs_cases","pred_rep_cases")
p6<-ggplot(df,aes(x=index,y=pred_cases)) + geom_line(colour="blue") + geom_area(fill="cadetblue3") + 
  geom_line(aes(x=index,y=pred_rep_cases,colour="red3"),show.legend=F)+
  scale_x_continuous(breaks=seq(xmin,xmax,31),labels=como_output[seq(xmin,xmax,31),"date"]) + labs(x="Date",y="Daily total cases") + 
  ggtitle("Unmitigated - \nfinal attack rate = 66%")+theme(axis.text.x=element_text(angle=45,hjust=1,size=12),axis.text.y=element_text(size=12),axis.title=element_text(size=14),plot.title=element_text(hjust=0.5,size=14,face="bold"))+
  scale_y_continuous(breaks = seq(0,ymax, by = 10000))+ylim(0,ymax)

library(gridExtra)
dev.new(width=10,height=10,noRStudioGD = T)
grid.arrange(p1,p2,p3,p4,p5,p6,ncol=2,nrow=3)
ggsave("Daily cases - all - short term.pdf",plot=grid.arrange(p1,p2,p3,p4,p5,p6,ncol=2,nrow=3),device="pdf",width=10,height=10)


#LONG TERM
end_date1<-as.Date("2020-01-28")# End date for comparing results to observed cumulative deaths
end_date2<-as.Date("2020-12-31")# End date for future scenarios

#Base Case
como_output<-read.csv(filename1,header=T,colClasses=c(rep("character",126)))
como_output[,2:ncol(como_output)]<-as.numeric(as.matrix(como_output[,2:ncol(como_output)]))
como_output[,1]<-as.Date(como_output[,1])
#ymax=2000000
ymax=500000
xmin<-as.numeric(como_output[1,"date"]+1-como_output[1,"date"])
xmax<-as.numeric(end_date2+1-como_output[1,"date"])
df<-data.frame(seq(xmin,xmax),como_output[seq(xmin,xmax),"baseline_predicted_reported_and_unreported_med"],como_output[seq(xmin,xmax),"input_cases"],como_output[seq(xmin,xmax),"baseline_predicted_reported_med"])
names(df)<-c("index","pred_cases","obs_cases","pred_rep_cases")
p1<-ggplot(df,aes(x=index,y=pred_cases)) + geom_line(colour="blue") + geom_area(fill="cadetblue3") + 
  geom_line(aes(x=index,y=pred_rep_cases,colour="red3"),show.legend=F)+
  scale_x_continuous(breaks=seq(xmin,xmax,31),labels=como_output[seq(xmin,xmax,31),"date"]) + labs(x="Date",y="Daily total cases") + 
  ggtitle("High Ro - \nfinal attack rate = 37.2%")+theme(axis.text.x=element_text(angle=45,hjust=1,size=12),axis.text.y=element_text(size=12),axis.title=element_text(size=14),plot.title=element_text(hjust=0.5,size=14,face="bold"))+
  scale_y_continuous(breaks = seq(0,ymax, by = 10000))+ylim(0,ymax)


#Scenario 2
como_output<-read.csv(filename2,header=T,colClasses=c(rep("character",126)))
como_output[,2:ncol(como_output)]<-as.numeric(as.matrix(como_output[,2:ncol(como_output)]))
como_output[,1]<-as.Date(como_output[,1])
xmin<-as.numeric(como_output[1,"date"]+1-como_output[1,"date"])
xmax<-as.numeric(end_date2+1-como_output[1,"date"])
df<-data.frame(seq(xmin,xmax),como_output[seq(xmin,xmax),"baseline_predicted_reported_and_unreported_med"],como_output[seq(xmin,xmax),"input_cases"],como_output[seq(xmin,xmax),"baseline_predicted_reported_med"])
names(df)<-c("index","pred_cases","obs_cases","pred_rep_cases")
p2<-ggplot(df,aes(x=index,y=pred_cases)) + geom_line(colour="blue") + geom_area(fill="cadetblue3") + 
  geom_line(aes(x=index,y=pred_rep_cases,colour="red3"),show.legend=F)+
  scale_x_continuous(breaks=seq(xmin,xmax,31),labels=como_output[seq(xmin,xmax,31),"date"]) + labs(x="Date",y="Daily total cases") + 
  ggtitle("Moderate Ro - \nfinal attack rate = 31.9%")+theme(axis.text.x=element_text(angle=45,hjust=1,size=12),axis.text.y=element_text(size=12),axis.title=element_text(size=14),plot.title=element_text(hjust=0.5,size=14,face="bold"))+
  scale_y_continuous(breaks = seq(0,ymax, by = 10000))+ylim(0,ymax)


#Scenario 3
como_output<-read.csv(filename3,header=T,colClasses=c(rep("character",126)))
como_output[,2:ncol(como_output)]<-as.numeric(as.matrix(como_output[,2:ncol(como_output)]))
como_output[,1]<-as.Date(como_output[,1])
xmin<-as.numeric(como_output[1,"date"]+1-como_output[1,"date"])
xmax<-as.numeric(end_date2+1-como_output[1,"date"])
df<-data.frame(seq(xmin,xmax),como_output[seq(xmin,xmax),"baseline_predicted_reported_and_unreported_med"],como_output[seq(xmin,xmax),"input_cases"],como_output[seq(xmin,xmax),"baseline_predicted_reported_med"])
names(df)<-c("index","pred_cases","obs_cases","pred_rep_cases")
p3<-ggplot(df,aes(x=index,y=pred_cases)) + geom_line(colour="blue") + geom_area(fill="cadetblue3") + 
  geom_line(aes(x=index,y=pred_rep_cases,colour="red3"),show.legend=F)+
  scale_x_continuous(breaks=seq(xmin,xmax,31),labels=como_output[seq(xmin,xmax,31),"date"]) + labs(x="Date",y="Daily total cases") + 
  ggtitle("Low Ro - \nfinal attack rate = 31.1%")+theme(axis.text.x=element_text(angle=45,hjust=1,size=12),axis.text.y=element_text(size=12),axis.title=element_text(size=14),plot.title=element_text(hjust=0.5,size=14,face="bold"))+
  scale_y_continuous(breaks = seq(0,ymax, by = 10000))+ylim(0,ymax)

#Scenario 4
como_output<-read.csv(filename4,header=T,colClasses=c(rep("character",126)))
como_output[,2:ncol(como_output)]<-as.numeric(as.matrix(como_output[,2:ncol(como_output)]))
como_output[,1]<-as.Date(como_output[,1])
xmin<-as.numeric(como_output[1,"date"]+1-como_output[1,"date"])
xmax<-as.numeric(end_date2+1-como_output[1,"date"])
df<-data.frame(seq(xmin,xmax),como_output[seq(xmin,xmax),"baseline_predicted_reported_and_unreported_med"],como_output[seq(xmin,xmax),"input_cases"],como_output[seq(xmin,xmax),"baseline_predicted_reported_med"])
names(df)<-c("index","pred_cases","obs_cases","pred_rep_cases")
p4<-ggplot(df,aes(x=index,y=pred_cases)) + geom_line(colour="blue") + geom_area(fill="cadetblue3") + 
  geom_line(aes(x=index,y=pred_rep_cases,colour="red3"),show.legend=F)+
  scale_x_continuous(breaks=seq(xmin,xmax,31),labels=como_output[seq(xmin,xmax,31),"date"]) + labs(x="Date",y="Daily total cases") + 
  ggtitle("High mask coverage - \nfinal attack rate = 26.2%")+theme(axis.text.x=element_text(angle=45,hjust=1,size=12),axis.text.y=element_text(size=12),axis.title=element_text(size=14),plot.title=element_text(hjust=0.5,size=14,face="bold"))+
  scale_y_continuous(breaks = seq(0,ymax, by = 10000))+ylim(0,ymax)

#Scenario 5
como_output<-read.csv(filename5,header=T,colClasses=c(rep("character",126)))
como_output[,2:ncol(como_output)]<-as.numeric(as.matrix(como_output[,2:ncol(como_output)]))
como_output[,1]<-as.Date(como_output[,1])
xmin<-as.numeric(como_output[1,"date"]+1-como_output[1,"date"])
xmax<-as.numeric(end_date2+1-como_output[1,"date"])
df<-data.frame(seq(xmin,xmax),como_output[seq(xmin,xmax),"baseline_predicted_reported_and_unreported_med"],como_output[seq(xmin,xmax),"input_cases"],como_output[seq(xmin,xmax),"baseline_predicted_reported_med"])
names(df)<-c("index","pred_cases","obs_cases","pred_rep_cases")
p5<-ggplot(df,aes(x=index,y=pred_cases)) + geom_line(colour="blue") + geom_area(fill="cadetblue3") + 
  geom_line(aes(x=index,y=pred_rep_cases,colour="red3"),show.legend=F)+
  scale_x_continuous(breaks=seq(xmin,xmax,31),labels=como_output[seq(xmin,xmax,31),"date"]) + labs(x="Date",y="Daily total cases") + 
  ggtitle("High Ro - \nfinal attack rate = 33.8%")+theme(axis.text.x=element_text(angle=45,hjust=1,size=12),axis.text.y=element_text(size=12),axis.title=element_text(size=14),plot.title=element_text(hjust=0.5,size=14,face="bold"))+
  scale_y_continuous(breaks = seq(0,ymax, by = 10000))+ylim(0,ymax)

#Scenario 6
como_output<-read.csv(filename6,header=T,colClasses=c(rep("character",126)))
como_output[,2:ncol(como_output)]<-as.numeric(as.matrix(como_output[,2:ncol(como_output)]))
como_output[,1]<-as.Date(como_output[,1])
xmin<-as.numeric(como_output[1,"date"]+1-como_output[1,"date"])
xmax<-as.numeric(end_date2+1-como_output[1,"date"])
df<-data.frame(seq(xmin,xmax),como_output[seq(xmin,xmax),"baseline_predicted_reported_and_unreported_med"],como_output[seq(xmin,xmax),"input_cases"],como_output[seq(xmin,xmax),"baseline_predicted_reported_med"])
names(df)<-c("index","pred_cases","obs_cases","pred_rep_cases")
p6<-ggplot(df,aes(x=index,y=pred_cases)) + geom_line(colour="blue") + geom_area(fill="cadetblue3") + 
  geom_line(aes(x=index,y=pred_rep_cases,colour="red3"),show.legend=F)+
  scale_x_continuous(breaks=seq(xmin,xmax,31),labels=como_output[seq(xmin,xmax,31),"date"]) + labs(x="Date",y="Daily total cases") + 
  ggtitle("Unmitigated - \nfinal attack rate = 66%")+theme(axis.text.x=element_text(angle=45,hjust=1,size=12),axis.text.y=element_text(size=12),axis.title=element_text(size=14),plot.title=element_text(hjust=0.5,size=14,face="bold"))+
  scale_y_continuous(breaks = seq(0,ymax, by = 10000))+ylim(0,ymax)

library(gridExtra)
dev.new(width=10,height=10,noRStudioGD = T)
grid.arrange(p1,p2,p3,p4,p5,p6,ncol=2,nrow=3)
ggsave("Daily cases - all - long term.pdf",plot=grid.arrange(p1,p2,p3,p4,p5,p6,ncol=2,nrow=3),device="pdf",width=10,height=10)


dev.new(width=10,height=10,noRStudioGD = T)
grid.arrange(p5,p4,p1,p6,ncol=2,nrow=2)
ggsave("Daily cases - all - long term - interv.pdf",plot=grid.arrange(p5,p4,p1,p6,ncol=2,nrow=2),device="pdf",width=10,height=10)

dev.new(width=6,height=10,noRStudioGD = T)
grid.arrange(p5,p2,p3,ncol=1,nrow=3)
ggsave("Daily cases - all - long term - Ro.pdf",plot=grid.arrange(p5,p2,p3,ncol=1,nrow=3),device="pdf",width=6,height=10)

#Scenario 7
como_output<-read.csv(filename7,header=T,colClasses=c(rep("character",126)))
como_output[,2:ncol(como_output)]<-as.numeric(as.matrix(como_output[,2:ncol(como_output)]))
como_output[,1]<-as.Date(como_output[,1])
xmin<-as.numeric(como_output[1,"date"]+1-como_output[1,"date"])
xmax<-as.numeric(end_date2+1-como_output[1,"date"])
df<-data.frame(seq(xmin,xmax),como_output[seq(xmin,xmax),"baseline_predicted_reported_and_unreported_med"],como_output[seq(xmin,xmax),"input_cases"],como_output[seq(xmin,xmax),"baseline_predicted_reported_med"])
names(df)<-c("index","pred_cases","obs_cases","pred_rep_cases")
p7<-ggplot(df,aes(x=index,y=pred_cases)) + geom_line(colour="blue") + geom_area(fill="cadetblue3") + 
  geom_line(aes(x=index,y=pred_rep_cases,colour="red3"),show.legend=F)+
  scale_x_continuous(breaks=seq(xmin,xmax,31),labels=como_output[seq(xmin,xmax,31),"date"]) + labs(x="Date",y="Daily total cases") + 
  ggtitle("No masks from September- \nfinal attack rate = 27.2%")+theme(axis.text.x=element_text(angle=45,hjust=1,size=16),axis.text.y=element_text(size=16),axis.title=element_text(size=18),plot.title=element_text(hjust=0.5,size=20,face="bold"))+
  scale_y_continuous(breaks = seq(0,ymax, by = 10000))+ylim(0,ymax)

#Scenario 8
como_output<-read.csv(filename8,header=T,colClasses=c(rep("character",126)))
como_output[,2:ncol(como_output)]<-as.numeric(as.matrix(como_output[,2:ncol(como_output)]))
como_output[,1]<-as.Date(como_output[,1])
xmin<-as.numeric(como_output[1,"date"]+1-como_output[1,"date"])
xmax<-as.numeric(end_date2+1-como_output[1,"date"])
df<-data.frame(seq(xmin,xma!W9VNYN!x),como_output[seq(xmin,xmax),"baseline_predicted_reported_and_unreported_med"],como_output[seq(xmin,xmax),"input_cases"],como_output[seq(xmin,xmax),"baseline_predicted_reported_med"])
names(df)<-c("index","pred_cases","obs_cases","pred_rep_cases")
p8<-ggplot(df,aes(x=index,y=pred_cases)) + geom_line(colour="blue") + geom_area(fill="cadetblue3") + 
  geom_line(aes(x=index,y=pred_rep_cases,colour="red3"),show.legend=F)+
  scale_x_continuous(breaks=seq(xmin,xmax,31),labels=como_output[seq(xmin,xmax,31),"date"]) + labs(x="Date",y="Daily total cases") + 
  ggtitle("Face mask coverage 25%- \nfinal attack rate = 25%")+theme(axis.text.x=element_text(angle=45,hjust=1,size=16),axis.text.y=element_text(size=16),axis.title=element_text(size=18),plot.title=element_text(hjust=0.5,size=20,face="bold"))+
  scale_y_continuous(breaks = seq(0,ymax, by = 10000))+ylim(0,ymax)

ggsave("Egypt Daily Cases Base Case and No Masks Sept.png",plot=grid.arrange(p8,p7,nrow=1,ncol=2),width=12,height=5,device="png")

