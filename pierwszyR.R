#api.openweathermap.org
print("hello world")

#instalacja bibliotek
#install.packages("httr")
#install.packages("jsonlite")

#zaladowanie zainstalowanych bibliotek
library(httr)
library(jsonlite)
installed.packages()

endpoint<-"http://api.openweathermap.org/data/2.5/weather?q=Lublin&units=metric&appid=kluczAPI"
getWeather <- httr::GET(endpoint)
weatherText<-content(getWeather,"text")
weatherJson<-fromJSON(weatherText,flatten = TRUE)
weatherDF<- as.data.frame(weatherJson)
View(weatherDF)

x<-"to jest zmienna"
x
x<-123
x
?vector
class(x)

?c
x<-c(1,2,3,4,5)
class(x)
x<-c("jeden","dwa","trzy")
class(x)

mojVector<-vector("numeric",10)
mojVector
mojVector<-c(1,2,3,4,5)
mojVector
mojVector<-c(1,2,3,4,5,FALSE)
mojVector
mojVector<-c(1,2,3,4,5,FALSE,"234")

mojVector<-c(1,2,3,4,5,FALSE,"234")
mojVector<-as.logical(mojVector)
mojVector
mojVector<-c(1,2,3.5,FALSE)
mojVector<-as.logical(mojVector)
mojVector
mojVector<-c(-1,2,0,3.5,FALSE)
mojVector<-as.logical(mojVector)
mojVector
mojVector<-c(-1,2,3.5,FALSE)
mojVector<-as.numeric(mojVector)

mojVector<-c(-1,2,0,3.5,FALSE)
mojVector<-as.logical(mojVector)
mojVector<-as.numeric(mojVector)
mojVector

wektor1<-seq(1,10,1)
wektor1
wektor2<-seq(10,1,-1)
wektor2

wynikD<-wektor1+wektor2
wynikD
wynikO<-wektor1-wektor2
wynikO
wynikM<-wektor1*wektor2
wynikM
wynikDz<-wektor1/wektor2
wynikDz
wynikP<-wektor1^wektor2
wynikP
#^2 - potega

wektor1<-seq(1,10,1)
wektor2<-seq(10,7,-1)
wynikD<-wektor1+wektor2
wynikO<-wektor1-wektor2
wynikM<-wektor1*wektor2
wynikDz<-wektor1/wektor2
wynikP<-wektor1^wektor2

wektor1<-seq(1,10,1)
wektor2<-2
wektor1/wektor2
wektor1%/%wektor2
wektor1%%wektor2

wektor1<-seq(1,10,1)
wektor2<-3
wektor1/wektor2
wektor1%/%wektor2
wektor1%%wektor2

lista<- list(c(1,2,3,4,5),c("jeden","dwa","trzy"),c(TRUE,FALSE))
lista

lista[[2]]
lista [[2]] [2]
lista[[1]][lista[[1]]>2]
lista[[2]][lista[[1]]>2]

v<- lista[[1]]
vl<-v[v>2]
vl
vl<-v[v>2];vl

plec<-c("mezczyzna","kobieta","mezczyzna","kobieta","kobieta")
class(plec)

plecf<-as.factor(plec)
class(plecf)
unclass(plecf)
class(plecf)

?factor
plecf<- factor(c("mezczyzna","kobieta","mezczyzna","kobieta","kobieta"),levels=c("mezczyzna","kobieta") )
plecf
class(plecf)
unclass(plecf)

plecf[3:5]<-NA
plecf

is.na(plecf)
plecf[is.na(plecf)]
!is.na(plecf)
plecf[!is.na(plecf)]
complete.cases(plecf)

?data.frame
df<- data.frame(index=c(1,2,3),imie=c("jan","ala","bartek"),plec=factor(c("mezczyzna","kobieta","mezczyzna")) )
View(df)

getwd()
?read.csv
data<-read.csv("dane.csv",header=TRUE,sep=";",dec=",")
data<-read.csv2("dane.csv")
View(data)

data$wiek
data$wzrost
data$waga

length(data) #liczba kolumn
length(data$wzrost) #liczba wierszy

len<-length(data$wzrost)
for( i in 1 : len){
  #print(data$wzrost[i])
  print(data$waga[i]/(data$wzrost[i]/100)^2)
  #BMI
}

#len<-length(data$wzrost)
#for( i in 1 : len){
#  print(data$waga/(data$wzrost/100)^2)
#}

print(data$waga/(data$wzrost/100)^2)

len<-length(data$wzrost)
i<-1
while(i<=len){
  data$bmi[i]<-(data$waga[i]/(data$wzrost[i]/100)^2)
  i<-i+1
}
View(data)

data$bmi2 <-(data$waga/(data$wzrost/100)^2)
View(data)
data$bmi2

#z wartoscia domyslna
hello<-function(x=c("hello")){
  print(paste(x, "RSTUDIO",sep=" "))
}
hello()

#bez wartosci domyslnej - blad
hello<-function(x){
  print(paste(x, "RSTUDIO",sep=" "))
}
hello()

#z wartoscia domyslna
hello<-function(x=c("hello")){
  print(paste(x, "RSTUDIO",sep=" "))
}
hello(x="dzien dobry")

#z wartoscia domyslna
hello<-function(x=c("hello","bye")){
  print(paste(x, "RSTUDIO",sep=" "))
}
hello()

?match
liczBMI<-function(masa,wzrost){
  k<-match(0,wzrost)
  print(k)
  if(!is.na(k)){
    bmi<-"dzielenie przez zero"
  }else{
    bmi<- masa/(wzrost/100)^2
  }
  bmi
}
liczBMI(masa=c(100,200),wzrost=c(200,200))
liczBMI(masa=c(100,200),wzrost=c(200,0))

liczBMI<-function(masa,wzrost){
  bmi<- masa/(wzrost/100)^2
  bmi
}
liczBMI(masa=c(100,200),wzrost=c(200,0))

liczBMI<-function(masa,wzrost){
  k<-match(0,wzrost)
  #print(k)
  if(!is.na(k)){
    #bmi<-"dzielenie przez zero"
  }else{
    bmi<- masa/(wzrost/100)^2
  }
  bmi
}
liczBMI(masa=c(100,200),wzrost=c(200,0))

liczBMI2<- function( ){
  komunikat<- "podaj mase i wzrost oddzielone przecinkiem:"
  odp <- strsplit( readline(komunikat),",")
  print(odp)
  print(odp[[1]])
  wektorOdp<- wektorOdp<- as.numeric( odp[[1]] )
  bmi<-  wektorOdp[1] /  ( wektorOdp[2]/100)^2 
  bmi
}
#liczBMI2()

liczBMI2<- function( ){
  komunikat<- "podaj mase i wzrost oddzielone przecinkiem:"
  wektorOdp<- wektorOdp<- as.numeric( strsplit( readline(komunikat),",")[[1]] )
  bmi<-  wektorOdp[1] /  ( wektorOdp[2]/100)^2 
  bmi
}
