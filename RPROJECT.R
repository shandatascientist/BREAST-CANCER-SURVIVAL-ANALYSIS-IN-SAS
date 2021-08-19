#ggplot2

library(ggplot2)

df = read.csv("R.csv")

str(df)

#Scatter plot - TREATMENT/PAYMENT TYPE/INSTITUTION
ggplot(df,aes(x=TREATMENT,y=TYPE))+geom_point(size=3,aes(col = INSTITUTION))

ggplot(df,aes(x=TREATMENT,y=TYPE))+geom_point(size=4,aes(col = INSTITUTION, shape = INSTITUTION))

R.p <- ggplot(df,aes(x = TYPE,y = CLASS))

R.p+geom_point(size=3,aes(col = INSTITUTION, shape = INSTITUTION))

#Addition line to plot - INSTITUTION

R.p+geom_point(size=3,aes(col = INSTITUTION, shape = INSTITUTION))+stat_smooth(method = lm,se=FALSE)

R.p+geom_point(size=3,aes(col = INSTITUTION, shape = INSTITUTION))+stat_smooth(method = lm,se=FALSE,aes(color=INSTITUTION))

R.p+geom_point(size=3,aes(col = INSTITUTION, shape = INSTITUTION))+
  stat_smooth(method = lm,se=FALSE,aes(color=INSTITUTION))+
  labs(title = "Relation between CLASS and TYPE",
       x = "TYPE",y = "CLASS",caption = "SHAN'S PROJECT",subtitle = "CANCER DATASET")

#Bar plot - SURVIVAL/AGE/TREATMENT

ggplot(df, aes(x=DFS))+geom_bar(fill=c("red","green"))

ggplot(df, aes(x=DFS,fill=STAGE))+geom_bar()

ggplot(df, aes(x=DFS,fill=TREATMENT))+geom_bar(position = "dodge")

ggplot(df, aes(x=DFS,fill=TYPE))+geom_bar(position = "dodge")

#Histogram & Bar graph - AGE

ggplot(df, aes(x=AGE))+geom_histogram(binwidth = 5)

ggplot(df, aes(x=AGE))+geom_histogram(binwidth = 10,col="blue",fill="green")+
  labs(title = "Age Column",x="Age","Count")


table(df$DFS)

# AGE AND DFS
ggplot(df, aes(x=AGE,fill=DFS))+geom_bar()

ggplot(df,aes(x=AGE,y=DFS))+geom_point(size=3,aes(col = DFS))

#AGE AND INSTITUTION
ggplot(df, aes(x=AGE,fill=INSTITUTION))+geom_bar()

ggplot(df,aes(x=AGE,y=INSTITUTION))+geom_point(size=3,aes(col = DFS))

#AGE AND TYPE
ggplot(df, aes(x=AGE,fill=TYPE))+geom_bar()

ggplot(df,aes(x=AGE,y=TYPE))+geom_point(size=3,aes(col = DFS))
ggplot(df,aes(x=AGE,y=TYPE))+geom_point(size=4,aes(col = DFS, shape = DFS))

#KAPLAN-MEIER SURVIVAL ANALYSIS
#DISEASE FREE SURVIVAL DURATION
#STAGE
#AGE

library(dplyr)
library(survival)
library(survminer)

head(df)
class(df)
dim(df)
View(df)

as_tibble(df)
df  <- as_tibble(df)
df

s <- Surv(df$TIME, df$DFS)
class(s)
s
head(df)

survfit(s~1)
survfit(Surv(TIME, DFS)~1, data=df)
sfit <- survfit(Surv(TIME, DFS)~1, data=df)
sfit

summary(sfit)

sfit <- survfit(Surv(TIME, DFS)~STAGE, data=lung)
sfit
summary(sfit)

range(df$TIME)
seq(0, 1100, 100)

summary(sfit, TIME=seq(0, 1000, 100))

sfit <- survfit(Surv(TIME, DFS)~STAGE, data=df)
plot(sfit)

library(survminer)
ggsurvplot(sfit)

coxph(Surv(TIME, DFS)~AGE, data=df)

ggsurvplot(survfit(Surv(TIME, DFS)~AGE, data=df))


