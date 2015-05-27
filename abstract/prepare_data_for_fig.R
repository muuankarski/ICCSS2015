## fixed over time

## Presidential election 2012
df <- read.csv("data/election_presidential_2012.csv")
library(reshape2)

dl <- melt(df, id.vars="item")
library(stringr)
dl$variable <- str_replace_all(dl$variable, "\\.", " ") # dots into spaces
dl$variable <- str_replace_all(dl$variable, "  ", " ") # double space into single
dl$variable <- str_replace_all(dl$variable, "  ", " ") # double space into single
dl$variable <- str_replace_all(dl$variable, "  ", " ") # double space into single
dl$variable <- str_replace_all(dl$variable, "  ", " ") # double space into single
dl$variable <- str_trim(dl$variable, side = "both") # whitespace from either end

names(dl)[names(dl)=="variable"] <- "region"
names(dl)[names(dl)=="item"] <- "indicator_en"

dl$indicator_ru <- NA
dl$unit <- "percent"
dl$class <- "presidential election 2012"

dlx <- dl

dl <- data.frame()
for (i in 1992:2014) {
  dd <- dlx
  dd$variable <- i
  dl <- rbind(dl,dd)
}

# remove other items but voting shares
table(dl$indicator_en)
dl <- dl[ with(dl, grepl("Share of", indicator_en)),]
dl$indicator_en <- factor(dl$indicator_en)


dfA <- data.frame()
dfA <- rbind(dfA,dl)

## ---------
## ---------

## Presidential election 2012
df <- read.csv("data/election_presidential_2008.csv")
library(reshape2)

dl <- melt(df, id.vars="item")
library(stringr)
dl$variable <- str_replace_all(dl$variable, "\\.", " ") # dots into spaces
dl$variable <- str_replace_all(dl$variable, "  ", " ") # double space into single
dl$variable <- str_replace_all(dl$variable, "  ", " ") # double space into single
dl$variable <- str_replace_all(dl$variable, "  ", " ") # double space into single
dl$variable <- str_replace_all(dl$variable, "  ", " ") # double space into single
dl$variable <- str_trim(dl$variable, side = "both") # whitespace from either end

names(dl)[names(dl)=="variable"] <- "region"
names(dl)[names(dl)=="item"] <- "indicator_en"

dl$indicator_ru <- NA
dl$unit <- "percent"
dl$class <- "presidential election 2008"

dlx <- dl

dl <- data.frame()
for (i in 1992:2014) {
  dd <- dlx
  dd$variable <- i
  dl <- rbind(dl,dd)
}

# remove other items but voting shares
table(dl$indicator_en)
dl <- dl[ with(dl, grepl("Share of", indicator_en)),]
dl$indicator_en <- factor(dl$indicator_en)

dfA <- rbind(dfA,dl)

## ---------
## ---------

## Duma election 2011
df <- read.csv("data/election_duma_2011.csv")
library(reshape2)

dl <- melt(df, id.vars="item")
library(stringr)
dl$variable <- str_replace_all(dl$variable, "\\.", " ") # dots into spaces
dl$variable <- str_replace_all(dl$variable, "  ", " ") # double space into single
dl$variable <- str_replace_all(dl$variable, "  ", " ") # double space into single
dl$variable <- str_replace_all(dl$variable, "  ", " ") # double space into single
dl$variable <- str_trim(dl$variable, side = "both") # whitespace from either end

dl$item <- str_replace_all(dl$item, '"', '') # quotation marks off

names(dl)[names(dl)=="variable"] <- "region"
names(dl)[names(dl)=="item"] <- "indicator_en"

dl$indicator_ru <- NA
dl$unit <- "percent"
dl$class <- "duma election 2011"

dlx <- dl

dl <- data.frame()
for (i in 1992:2014) {
  dd <- dlx
  dd$variable <- i
  dl <- rbind(dl,dd)
}

# remove other items but voting shares
table(dl$indicator_en)
dl <- dl[ with(dl, grepl("Share of", indicator_en)),]
dl$indicator_en <- factor(dl$indicator_en)

dfA <- rbind(dfA,dl)

## ---------
## ---------

## Duma election 2007
df <- read.csv("data/election_duma_2007.csv")
library(reshape2)

dl <- melt(df, id.vars="item")
library(stringr)
dl$variable <- str_replace_all(dl$variable, "\\.", " ") # dots into spaces
dl$variable <- str_replace_all(dl$variable, "  ", " ") # double space into single
dl$variable <- str_replace_all(dl$variable, "  ", " ") # double space into single
dl$variable <- str_replace_all(dl$variable, "  ", " ") # double space into single
dl$variable <- str_trim(dl$variable, side = "both") # whitespace from either end

dl$item <- str_replace_all(dl$item, '"', '') # quotation marks off

names(dl)[names(dl)=="variable"] <- "region"
names(dl)[names(dl)=="item"] <- "indicator_en"

dl$indicator_ru <- NA
dl$unit <- "percent"
dl$class <- "duma election 2007"

dlx <- dl

dl <- data.frame()
for (i in 1992:2014) {
  dd <- dlx
  dd$variable <- i
  dl <- rbind(dl,dd)
}

# remove other items but voting shares
table(dl$indicator_en)
dl <- dl[ with(dl, grepl("Share of", indicator_en)),]
dl$indicator_en <- factor(dl$indicator_en)

dfA <- rbind(dfA,dl)

## List of current heads of federal subjects of Russia
# http://en.wikipedia.org/wiki/List_of_current_heads_of_federal_subjects_of_Russia

library(XML)
theurl <- "http://en.wikipedia.org/wiki/Regional_parliaments_of_Russia"
tables <- readHTMLTable(theurl)
n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))

t <- tables[[which.max(n.rows)]]
t <- t[c(-1,-23,-33,-80.-82,-87,-91,-92),] # remove uselees rows

names(t)[1] <- "region"
df <- t[c(1,2,4:11)]
dl <- melt(df, id.vars="region")

dl$value <- as.factor(dl$value)
dl$value <- as.numeric(levels(dl$value))[dl$value]

dw <- dcast(dl, region  ~ variable, value.var="value")
dw[3] <- NULL

dw[3] <- dw[3] / dw[2] * 100
dw[4] <- dw[4] / dw[2] * 100
dw[5] <- dw[5] / dw[2] * 100
dw[6] <- dw[6] / dw[2] * 100
dw[7] <- dw[7] / dw[2] * 100
dw[8] <- dw[8] / dw[2] * 100
dw[9] <- dw[9] / dw[2] * 100

names(dw) <- c("region_en","Seats","united_russia","communist","just_russia","liberal_democrat","patriots","right_cause","yabloko")
dw[2] <- NULL

dl <- melt(dw, id.vars="region_en")

# some region names are badly formatted, need to fix a bit
dl$region_en <- as.character(dl$region_en)

dl$region_en[dl$region_en == "Buryatia"] <- "Buryat Republic"
dl$region_en[dl$region_en == "Chechnya"] <- "Chechen Republic"
dl$region_en[dl$region_en == "Сhukotka Autonomous Okrug"] <- "Chukotka Autonomous Okrug"
dl$region_en[dl$region_en == "Chuvashia"] <- "Chuvash Republic"
dl$region_en[dl$region_en == "Kabardino-Balkaria"] <- "Kabardino-Balkaria Republic"
dl$region_en[dl$region_en == "Karachay-Cherkessia"] <- "Karachay-Cherkess Republic"
dl$region_en[dl$region_en == "Khanty–Mansi Autonomous Okrug – Yugra"] <- "Khanty-Mansiysk Autonomous Okrug"
dl$region_en[dl$region_en == "Mari El"] <- "Mari El Republic"
dl$region_en[dl$region_en == "Nenets\nAutonomous Okrug"] <- "Nenets Autonomous District"
dl$region_en[dl$region_en == "Adygea"] <- "Republic of Adygea"
dl$region_en[dl$region_en == "Bashkortostan"] <- "Republic of Bashkortostan"
dl$region_en[dl$region_en == "Dagestan"] <- "Republic of Dagestan"
dl$region_en[dl$region_en == "Ingushetia"] <- "Republic of Ingushetia"
dl$region_en[dl$region_en == "Kalmykia"] <- "Republic of Kalmykia"
dl$region_en[dl$region_en == "Karelia"] <- "Republic of Karelia"
dl$region_en[dl$region_en == "Khakassia"] <- "Republic of Khakassia"
dl$region_en[dl$region_en == "Mordovia"] <- "Republic of Mordovia"
dl$region_en[dl$region_en == "North Ossetia–Alania"] <- "Republic of North Ossetia - Alania"
dl$region_en[dl$region_en == "Tatarstan"] <- "Republic of Tatarstan"
dl$region_en[dl$region_en == "Tuva"] <- "Republic of Tyva"
dl$region_en[dl$region_en == "Sakha"] <- "Sakha Republic"
dl$region_en[dl$region_en == "Saint Petersburg"] <- "St. Petersburg"
dl$region_en[dl$region_en == "Udmurtia"] <- "Udmurt Republic"



library(RCurl)
GHurl <- getURL("https://raw.githubusercontent.com/muuankarski/data/master/russia/regionkey.csv")
dat <- read.csv(text = GHurl)

df <- merge(dl,dat,by="region_en")
dl <- df[c(2,3,5)]

dl$indicator_ru <- NA
dl$unit <- "percent"
dl$class <- "share of seats in regional parliaments"

names(dl)[names(dl)=="variable"] <- "indicator_en"
names(dl)[names(dl)=="russian"] <- "region"

dlx <- dl

dl <- data.frame()
for (i in 1992:2014) {
  dd <- dlx
  dd$variable <- i
  dl <- rbind(dl,dd)
}


dfA <- rbind(dfA,dl)

dfB <- dfA[dfA$variable == 2013,]

save(dfB, file="data/dfB.rda")

library(RCurl)
GHurl <- getURL("https://raw.githubusercontent.com/muuankarski/data/master/russia/regionkey.csv")
dat <- read.csv(text = GHurl)
# dat <-  dat[dat$ID > 0,]  # remove moscow city 
dat <- dat[!is.na(dat$ID),] # Russian Federation
# load election data
load("data/dfB.rda")
dfA <- dfB
source("data/trim_region_names.R")
# remove duplicates
dfA <- dfA[!duplicated(dfA[c("region","variable","indicator_en")]),]

dfA <- merge(dat,dfA,by.x="russian",by.y="region")


df1 <- dfA[dfA$indicator_en == "Share of Vserossiyskaya political party UNITED RUSSIA",]
df2 <- dfA[dfA$indicator_en == "Share of Dmitry Anatolyevich Medvedev",]
df3 <- dfA[dfA$indicator_en == "Share of Russian political party UNITED RUSSIA",]
df4 <- dfA[dfA$indicator_en == "Share of Vladimir Vladimirovich Putin",]  


dw1 <- dcast(df1, region_en + variable + federal_district + economic_regions + type_of_subject ~ indicator_en, value.var="value")
dw2 <- dcast(df2, region_en + variable + federal_district + economic_regions + type_of_subject ~ indicator_en, value.var="value")
dw3 <- dcast(df3, region_en + variable + federal_district + economic_regions + type_of_subject ~ indicator_en, value.var="value")
dw4 <- dcast(df4, region_en + variable + federal_district + economic_regions + type_of_subject ~ indicator_en, value.var="value")

dwx <- merge(dw1,dw2,by=c("region_en","variable","federal_district","economic_regions","type_of_subject"))
dwx <- merge(dwx,dw3,by=c("region_en","variable","federal_district","economic_regions","type_of_subject"))
dwx <- merge(dwx,dw4,by=c("region_en","variable","federal_district","economic_regions","type_of_subject"))

dfZZ <- na.omit(dwx) 

dfZZ$ID <- 1:nrow(dfZZ)

# Ei tarvi normalisoida, koska kaikki samaa yksikköä

# range01 <- function(x){(x-min(x))/(max(x)-min(x))}
# 
# dfZZ[6] <- range01(dfZZ[6])
# dfZZ[7] <- range01(dfZZ[7])
# dfZZ[8] <- range01(dfZZ[8])
# dfZZ[9] <- range01(dfZZ[9])


df.x <- melt(dfZZ,id.vars=c("ID","region_en","federal_district",
                            "economic_regions","type_of_subject"), 
             measure.vars = c("Share of Vserossiyskaya political party UNITED RUSSIA",
                              "Share of Dmitry Anatolyevich Medvedev",
                              "Share of Russian political party UNITED RUSSIA",
                              "Share of Vladimir Vladimirovich Putin"))

begindata <- df.x[df.x$variable == "Share of Vladimir Vladimirovich Putin",]
seconddata <- df.x[df.x$variable == "Share of Russian political party UNITED RUSSIA",]
thirddata <- df.x[df.x$variable == "Share of Dmitry Anatolyevich Medvedev",]
enddata <- df.x[df.x$variable == "Share of Vserossiyskaya political party UNITED RUSSIA",]

df.x$variable <- as.character(df.x$variable)

df.x$variable[df.x$variable == "Share of Vladimir Vladimirovich Putin"] <- "Presidential 2012 \n Vladimir Putin"
df.x$variable[df.x$variable == "Share of Russian political party UNITED RUSSIA"] <- "Duma 2011 \n United Russia"
df.x$variable[df.x$variable == "Share of Dmitry Anatolyevich Medvedev"] <- "Presidential 2008 \n Dimitry Medvedev"
df.x$variable[df.x$variable == "Share of Vserossiyskaya political party UNITED RUSSIA"] <- "Duma 2007 \n United Russia"

df.x$variable <- factor(df.x$variable, levels=c("Presidential 2012 \n Vladimir Putin",
                                                "Duma 2011 \n United Russia",
                                                "Presidential 2008 \n Dimitry Medvedev",
                                                "Duma 2007 \n United Russia"))

save.image(file="data/dfx.rda")

