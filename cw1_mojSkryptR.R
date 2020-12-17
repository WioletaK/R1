# wypisanie komunikatu
print("hello")

# przypisanie wartosci do zmiennej
x <- "hello"
x
print(x)
# W okienku "Environment" pojawi sie zmienna x.
# Beda tam tez widoczne inne stworzone przez nas elementy - funkcje, wektory, ramki danych i inne rzeczy

# getwd() pokazuje nam gdzie jest nasze "working directory" - katalog, w ktorym trzymamy nasze skrypty, pliki itd.
getwd()
print(getwd())


#instalowanie pakietow i ich ladowanie
#pakiet do konsumowania resta (API bedzie nam zwracalo jsonem pogode, a my przerobimy go sobie na DataFrame'a)
#api.openweathermap.org

#instalacja paczek
#install.packages("httr")
#install.packages("jsonlite")

#zaladowanie zainstalowanych bibliotek
library(httr)
library(jsonlite)

#informacja o wszystkich zainstalowanych paczkach
installed.packages()
?installed.packages
#W konsoli wyswietla nam sie ograniczona liczba paczek. Jesli chcemy zobaczyc wszystkie, musimy to zapisac do DataFrame'u.
pakietyDF <- as.data.frame(installed.packages())
View(pakietyDF)

#z uzyciem klucza L. Kwasniewicza, ktory po zajeciach zostal wylaczony
#endpoint<-"http://api.openweathermap.org/data/2.5/weather?q=Lublin&units=metric&appid=ccd2c7f8b414cadf0c4383ce0a541dc2"
#z uzyciem mojego klucza "Default"
#endpoint<-"http://api.openweathermap.org/data/2.5/weather?q=Warszawa&units=metric&appid=df418388b29f64e4c06470e70ec74f59"
#z uzyciem mojego klucza "key201215""
#endpoint<-"api.openweathermap.org/data/2.5/weather?q=Warszawa&units=metric&appid=4f7c49e6faf21631baab7265cfb1d05f"
#z uzyciem mojego klucza "Default" dla miasta Radzyń Podlaski
endpoint<-"http://api.openweathermap.org/data/2.5/weather?q=Radzy%C5%84%20Podlaski&units=metric&appid=keyAPI"
#endpoint<-"http://api.openweathermap.org/data/2.5/weather?q=Radzy%C5%84%20Podlaski&units=metric&appid=df418388b29f64e4c06470e70ec74f59"
endpoint
#Ten link mozna obejrzec w przegladarce. Zawartosc wyglada tak:
#{"coord":{"lon":22.62,"lat":51.78},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"base":"stations","main":{"temp":2.36,"feels_like":-1.77,"temp_min":2,"temp_max":2.78,"pressure":1021,"humidity":100},"visibility":10000,"wind":{"speed":3.6,"deg":160},"clouds":{"all":90},"dt":1608064196,"sys":{"type":1,"id":1702,"country":"PL","sunrise":1608013828,"sunset":1608041955},"timezone":3600,"id":760680,"name":"Radzyń Podlaski","cod":200}
#getWeather <- GET(endpoint)
#jesli mamy kilka funkcji, ktore moga sie nazywac tak samo, wtedy podajemy "nazwe_paczki::"
getWeather <- httr::GET(endpoint)
getWeather
#Z API dostalismy JSONa z pogoda.
weatherText <- content(getWeather,"text")
weatherText
#Widzimy rozne informacje (temp, min_temp, max_temp, zachmurzenie, widocznosc, predkosc wiatru itp.), ale sa one troche nieczytelne.
#Mozemy (korzystajac z paczki jsonlite) to sobie rozbic na JSONa.
weatherJson <- fromJSON(weatherText,flatten = TRUE)
#Wtedy mamy ladna rozbita liste.
weatherJson
#Mozemy ja sobie zapisac jako Data Frame.
weatherDF <- as.data.frame(weatherJson)
#I podejrzec.
View(weatherDF)
#Za pomoca dwoch bibliotek mozemy bardzo prosto zrobic cos skomplikowanego.
#Pobrac informacje o pogodzie z aplikacji WEBowej. Pobrac zawartosc w postaci JSONa i zamienic go na data frame'a.


#Co już wiemy o R?

#przypisanie do zmiennej za pomoca <-
x <-"to jest zmienna"
x
x <- 123
x

#Jakiego typu bedzie nasza zmienna x?
x <-"to jest zmienna"
class(x) #typ zmiennej
#[1] "character"
x <- 123
class(x)
#[1] "numeric"
#Tak naprawde kazda taka (nawet pojedyncza zmienna) w R jest wektorem. Jest to wektor z jednym elementem.
#Czyli nie mamy zmiennej, ktora jest liczba tylko zmienna, ktora jest wektorem z jedna liczba.

x <- c(1,2,3,4,5)
class(x)
#[1] "numeric"
?c #znak zapytania wyswietla pomoc
x<-c("jeden","dwa","trzy")
class(x)
#[1] "character"
x <- c(1,"a",3,4,5)
class(x)
#[1] "character"
x

#Garsc informacji na temat wektorow (Help):
?vector
#Dane w wektorze musza byc jednego typu.
#The atomic modes are "logical", "integer", "numeric" (synonym "double"), "complex", "character" and "raw".
#complex - liczby zespolone
x <- 1:100
x
class(x)
#[1] "integer"
#Mozna zrobic konwersje typow w wektorze.

mojVector<-vector("numeric",10)
mojVector
mojVector<-c(1,2,3,4,5)
mojVector
mojVector<-c(1,2,3,4,5,FALSE)
mojVector
class(mojVector)
#[1] "numeric"
#FALSE zamienil na 0 i skonwertowal do numeric
mojVector<-c(1,2,3,4,5,FALSE,"234")
mojVector
class(mojVector)
#[1] "character"
#Gdy dolozylismy jedna zmienna tekstowa, wszystkie zamienil na character.
mojVector<-c(1,2,3,4,5,FALSE,"6")
mojVector
class(mojVector)
#[1] "character"
#Nawet jesli ta zmienna wyglada jak cyfra.
#Konwersja jest w tym kierunku, w ktorym jest najbardziej mozliwa.
#Jesli jednym z el. wektora jest character, to wszystko zostanie zamienione na character.
mojVector<-c(1,2,3,4,5,FALSE, 1.5)
mojVector
#[1] 1.0 2.0 3.0 4.0 5.0 0.0 1.5
class(mojVector)
#[1] "numeric"
mojVector<-c(1,2,3,4,5,FALSE, 1.5,"12")
mojVector
#[1] "1"     "2"     "3"     "4"     "5"     "FALSE" "1.5"   "12"   
class(mojVector)
#[1] "character"

mojVector<-c(0,1,0,1,0,1)
class(mojVector)
#[1] "numeric"
mojVector<-as.logical(mojVector)
mojVector
#[1] FALSE  TRUE FALSE  TRUE FALSE  TRUE
class(mojVector)
#[1] "logical"

mojVector<-c(1,2,3,4,5,FALSE,"234")
class(mojVector)
mojVector<-as.logical(mojVector)
mojVector
#[1]    NA    NA    NA    NA    NA FALSE    NA
class(mojVector)

mojVector<-c(1,2,3.5,FALSE)
mojVector<-as.logical(mojVector)
mojVector
class(mojVector)
#[1]  TRUE  TRUE  TRUE FALSE
#Jesli w wektorze byly same liczby, to poradzil sobie z ich konwersja na typ logical.
#Podczas konwersji as.logical() 0 jest zamieniane na FALSE, a wszystkie inne liczby na TRUE.


mojVector<-c(-1,2,3.5,FALSE)
mojVector
#[1] -1.0  2.0  3.5  0.0
class(mojVector)
#[1] "numeric"
mojVector<-c(-1,2,0,3.5,FALSE)
mojVector<-as.logical(mojVector)
mojVector
#[1]  TRUE  TRUE FALSE  TRUE FALSE
mojVector<-as.numeric(mojVector)
mojVector
#[1] 1 1 0 1 0
#Gdy dokonamy konwersji wektora numeric na logical, a pozniej znowu na numeric, to nie dostaniemy juz liczb, ktore mielismy przed konwersja na logical.
#Dostaniemy jedynie 0-a i 1-ki.


#Czy mozna wykonywac operacje arytmetyczne na wektorach, np. liczbowych?
# + - * / ^

wektor1<-seq(1,10,1)
wektor1
#[1]  1  2  3  4  5  6  7  8  9 10
wektor2<-seq(10,1,-1)
wektor2
#[1] 10  9  8  7  6  5  4  3  2  1

wynikD<-wektor1+wektor2
wynikD
#[1] 11 11 11 11 11 11 11 11 11 11
wynikO<-wektor1-wektor2
wynikO
#[1] -9 -7 -5 -3 -1  1  3  5  7  9
wynikM<-wektor1*wektor2
wynikM
#[1] 10 18 24 28 30 30 28 24 18 10
wynikDz<-wektor1/wektor2
wynikDz
#[1]  0.1000000  0.2222222  0.3750000  0.5714286  0.8333333  1.2000000  1.7500000  2.6666667  4.5000000 10.0000000
wynikP<-wektor1^wektor2
wynikP
#[1]     1   512  6561 16384 15625  7776  2401   512    81    10
#^2 - potega

wektor1<-seq(1,10,1)
wektor1
#[1]  1  2  3  4  5  6  7  8  9 10
wektor2<-seq(10,7,-1)
wektor2
#[1] 10  9  8  7

wynikD<-wektor1+wektor2
#Komunikat ostrzegawczy:
#  W poleceniu 'wektor1 + wektor2':
#  długość dłuszego obiektu nie jest wielokrotnością długości krótszego obiektu
wynikD
#[1] 11 11 11 11 15 15 15 15 19 19
#Wektor2 wydluza do dlugosci wektora1, powtarzajac jego elementy (tak, zeby dalo sie wykonac operacje).
#Wyswietla przy tym komunikat ostrzegawczy o roznej dlugosci obiektow.
wynikO<-wektor1-wektor2
wynikO
#[1] -9 -7 -5 -3 -5 -3 -1  1 -1  1
wynikM<-wektor1*wektor2
wynikM
#[1] 10 18 24 28 50 54 56 56 90 90
wynikDz<-wektor1/wektor2
wynikDz
#[1] 0.1000000 0.2222222 0.3750000 0.5714286 0.5000000 0.6666667 0.8750000 1.1428571 0.9000000 1.1111111
wynikP<-wektor1^wektor2
wynikP
#[1]          1        512       6561      16384    9765625   10077696    5764801    2097152 3486784401 1000000000


#Czym beda sie roznily 3 operacje dzielenia wektorow: /, %/%, %% ?

wektor1<-seq(1,10,1)
wektor2<-2
wektor1/wektor2
#[1] 0.5 1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0
#Czesc calkowita z dzielenia
wektor1%/%wektor2
#[1] 0 1 1 2 2 3 3 4 4 5
#Reszta z dzielenia
wektor1%%wektor2
#[1] 1 0 1 0 1 0 1 0 1 0

wektor1<-seq(1,10,1)
wektor2<-3
wektor1/wektor2
#[1] 0.3333333 0.6666667 1.0000000 1.3333333 1.6666667 2.0000000 2.3333333 2.6666667 3.0000000 3.3333333
wektor1%/%wektor2
#[1] 0 0 1 1 1 2 2 2 3 3
wektor1%%wektor2
#[1] 1 2 0 1 2 0 1 2 0 1


#Mamy tez listy - tu moga wchodzic wektory. Wektor musibyc jednego typu, ale kolejne wektory w liscie moga byc roznych typow.
#Czyli mozemy miec jeden wektor numeryczny, drugi character, a trzeci logiczny.

lista <- list(c(1,2,3,4,5),c("jeden","dwa","trzy"),c(TRUE,FALSE))
lista
#[[1]]
#[1] 1 2 3 4 5
#[[2]]
#[1] "jeden" "dwa"   "trzy" 
#[[3]]
#[1]  TRUE FALSE

lista <- list(c(1,2,3,4,5),c("jeden","dwa","trzy"),c(TRUE,FALSE))
lista2 <- list(c(1,2,3,4,5),c("jeden","dwa","trzy"),c(TRUE,FALSE))
x <- c(1,lista,lista2)
x
#[[1]]
#[1] 1
#[[2]]
#[1] 1 2 3 4 5
#[[3]]
#[1] "jeden" "dwa"   "trzy" 
#[[4]]
#[1]  TRUE FALSE
#[[5]]
#[1] 1 2 3 4 5
#[[6]]
#[1] "jeden" "dwa"   "trzy" 
#[[7]]
#[1]  TRUE FALSE
class(x)
#[1] "list"

#Nie da sie stworzyc wektora list.
x <- as.vector(c(1,lista,lista2),mode="any")
x
class(x)
#[1] "list"

#Indeksowanie w R jest od 1.
lista[[2]] #zwraca drugi wektor z listy
#[1] "jeden" "dwa"   "trzy"
lista[[2]][2] #zwraca drugi element drugiego wektora
#[1] "dwa"
lista[[1]][lista[[1]]>2]
#[1] 3 4 5
lista[[1]]>2
#[1] FALSE FALSE  TRUE  TRUE  TRUE
lista[[2]][lista[[1]]>2]
#[1] "trzy" NA     NA   

v <- lista[[1]]
v
#[1] 1 2 3 4 5
v>2
#[1] FALSE FALSE  TRUE  TRUE  TRUE
vl <- v[v>2] #filtracja elementow wektora
vl
#[1] 3 4 5
vl <- v[v>2];vl #mozemy wyswietlic v1, zapisujac komende w tej samej linii, oddzialejac ja srednikiem
#[1] 3 4 5

plec <- c("mezczyzna","kobieta","mezczyzna","kobieta","kobieta")
class(plec)
#[1] "character"

plecf <- as.factor(plec)
class(plecf)
#[1] "factor"
plecf
#[1] mezczyzna kobieta   mezczyzna kobieta   kobieta  
#Levels: kobieta mezczyzna
unclass(plecf)
#[1] 2 1 2 1 1
#attr(,"levels")
#[1] "kobieta"   "mezczyzna"
plecf
#[1] mezczyzna kobieta   mezczyzna kobieta   kobieta  
#Levels: kobieta mezczyzna
class(plecf)
#[1] "factor"

?factor
plecf <- factor(c("mezczyzna","kobieta","mezczyzna","kobieta","kobieta"),levels=c("mezczyzna","kobieta") )
plecf
#[1] mezczyzna kobieta   mezczyzna kobieta   kobieta  
#Levels: mezczyzna kobieta
class(plecf)
#[1] "factor"
unclass(plecf)
#[1] 1 2 1 2 2
#attr(,"levels")
#[1] "mezczyzna" "kobieta"

plecf[3:5] <- NA
plecf
#[1] mezczyzna kobieta   <NA>      <NA>      <NA>     
#Levels: mezczyzna kobieta

is.na(plecf)
#[1] FALSE FALSE  TRUE  TRUE  TRUE
plecf[is.na(plecf)]
#[1] <NA> <NA> <NA>
#Levels: mezczyzna kobieta
!is.na(plecf)
#[1]  TRUE  TRUE FALSE FALSE FALSE
plecf[!is.na(plecf)]
#[1] mezczyzna kobieta  
#Levels: mezczyzna kobieta
complete.cases(plecf)
#[1]  TRUE  TRUE FALSE FALSE FALSE

?data.frame
df<- data.frame(index=c(1,2,3), imie=c("jan","ala","bartek"), plec=factor(c("mezczyzna","kobieta","mezczyzna")))
View(df)

getwd()
?read.table
data <- read.table("dane.csv", header=TRUE, sep=";")
View(data)
?read.csv
data <- read.csv("dane.csv")
View(data) #w pliku separatorem zmiennych jest srednik, a w read.csv domyslnie przecinek, wiec zaczytanie z uzyciem domyslnych opcji zaczyta wszystko jako jedna kolumne
data <- read.csv("dane.csv", header=TRUE, sep=";", dec=",")
View(data)
data <- read.csv2("dane.csv")
View(data)

data$wiek
#[1] 72 66 64 64 63 63 63 62 62 61 61 60 59 59 58 58 58 58 58 57 57 57 57 57 57 57 56 56 56 56 56 56 56 56 56 56 56 56 56 55 55 55 55 55 55 55 55 54 54
#[50] 54 54 54 54 54 54 54 54 54 54 53 53 53 53 53 53 53 52 52 52 52 52 52 52 52 52 52 52 51 51 51 51 51 51 51 51 51 51 51 51 51 51 51 51 50 50 50 50 50
#[99] 50 50 50 50 50 50 50 50 50 50 50 49 49 49 49 49 49 49 49 49 49 49 49 49 49 49 49 49 49 49 49 49 49 49 48 48 48 48 48 48 48 48 48 48 48 48 48 48 48
#[148] 48 48 48 48 48 48 48 48 47 47 47 47 47 47 47 47 47 47 47 47 47 47 47 47 47 47 46 46 46 46 46 46 46 46 46 46 46 46 46 46 46 46 46 46 46 46 46 46 46
#[197] 46 46 46 46 46 46 46 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 44 44 44 44 44 44 44 44 44 44 44 44
#[246] 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 44 43 43 43 43 43 43 43 43 43 43 43 43 43 43 43 43 43 43 43 43 43
#[295] 43 43 43 43 43 43 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 41 41 41 41 41 41 41
#[344] 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40
#[393] 40 40 40 40 40 40 40 40 40 40 40 40 40 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39 39
#[442] 39 39 39 39 39 39 39 39 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38 38
#[491] 38 38 38 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37
#[540] 37 36 36 36 36 36 36 36 36 36 36 36 36 36 36 36 36 36 36 36 36 36 36 36 36 36 36 36 35 35 35 35 35 35 35 35 35 35 35 35 35 35 35 35 35 35 35 35 35
#[589] 35 35 35 35 35 35 35 35 35 35 35 35 35 35 35 35 35 35 35 35 35 34 34 34 34 34 34 34 34 34 34 34 34 34 34 34 34 34 34 34 34 34 34 34 34 34 34 34 34
#[638] 34 34 34 34 34 34 34 34 34 34 34 34 34 34 34 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33 33
#[687] 33 33 33 33 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31
#[736] 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30
#[785] 29 29 29 29 29 29 29 29 29 29 29 29 29 29 29 29 29 29 29 29 29 29 29 29 29 29 29 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28
#[834] 28 28 28 28 28 28 28 28 28 28 28 27 27 27 27 27 27 27 27 27 27 27 27 27 27 27 27 27 27 27 27 27 27 27 27 27 27 27 27 26 26 26 26 26 26 26 26 26 26
#[883] 26 26 26 26 26 26 26 26 26 26 26 26 26 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 25 24 24 24 24 24 24 24 24 24 24 24 24 24 24 24 24 24 23 23
#[932] 23 23 23 23 23 23 23 23 23 22 22 22 22 22 22 22 22 22 22 22 22 22 22 21 21 21 21 21 21 21 21 21 21 21 21 21 20 20 20 20 20 20 37 37 37 37 37 37 37
#[981] 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37 37
data$wzrost
data$waga

length(data) #liczba kolumn
length(data$wzrost) #liczba wierszy

#Przechodzac po kolejnych rekordach z pliku, policzymy BMI
#len <- length(data$wzrost)
#for( i in 1 : len){
#  print(data$waga/(data$wzrost/100)^2)
#}
#tak nie, trzeba iterowac po elementach (wierszach) pliku

len <- length(data$wzrost)
for( i in 1 : len){
  #print(data$wzrost[i])
  print(data$waga[i]/(data$wzrost[i]/100)^2)
}

print(data$waga/(data$wzrost/100)^2)

#To samo mozemy zrobic w petli while
len <- length(data$wzrost)
i<-1
while(i<=len){
  data$bmi[i] <- (data$waga[i]/(data$wzrost[i]/100)^2)
  i <- i+1
}
View(data)

#To samo mozna zrobic nie przechodzac przez wszystkie elementy pojedynczo, ale biorac cale wektory danych
data$bmi2 <- (data$waga/(data$wzrost/100)^2)
View(data)
data$bmi2

#z wartoscia domyslna
hello <- function(x="hello"){
print(paste(x, "RSTUDIO",sep=" "))
}
hello()
#[1] "hello RSTUDIO"
#Ta funkcja juz sie zaladowala. Widzimy ja w zakladce Environment.

hello <- function(x=c("hello")){
  print(paste(x, "RSTUDIO", sep=" "))
  #jest jeszcze funkcja paste0, w ktorej mozemy zrobic print(paste0(x, " RSTUDIO"))
}
hello()
#[1] "hello RSTUDIO"

#bez wartosci domyslnej - blad
hello <- function(x){
  print(paste(x, "RSTUDIO",sep=" "))
}
hello()
#Błąd w poleceniu 'paste(x, "RSTUDIO", sep = " ")':
#  brakuje argumentu 'x', a nie ma określonej wartości domyślnej 

#z wartoscia domyslna
hello <- function(x=c("hello")){
  print(paste(x, "RSTUDIO",sep=" "))
}
hello(x="dzien dobry")
#[1] "dzien dobry RSTUDIO"

#z wartoscia domyslna w postaci wektora
hello<-function(x=c("hello","bye")){
  print(paste(x, "RSTUDIO",sep=" "))
}
hello()
#[1] "hello RSTUDIO" "bye RSTUDIO" 


#Chcemy napisac funkcje, ktora policzy nam BMI

?match
liczBMI <- function(masa,wzrost){
  k <- match(0,wzrost)
  print(k)
  if(!is.na(k)){
    bmi <- "dzielenie przez zero"
  }else{
    bmi <- masa/(wzrost/100)^2
  }
  bmi
}
liczBMI(masa=c(100,200),wzrost=c(200,200))
#[1] NA
#[1] 25 50
liczBMI(masa=c(100,200),wzrost=c(200,0))
#[1] 2
#[1] "dzielenie przez zero"
liczBMI(masa=c(100,200,100),wzrost=c(10,15,0))
#[1] 3
#[1] "dzielenie przez zero"

data <- read.csv2("dane.csv")
#View(data)

liczBMI <- function(masa,wzrost){
  k <- match(0,wzrost)
  if(!is.na(k)){
    bmi <- "dzielenie przez zero"
  }else{
    bmi <- masa/(wzrost/100)^2
  }
  #bmi #return nie trzeba dawac, bo zawsze daje ostatnia wartosc
}
wynik <- liczBMI(data$waga,data$wzrost)
wynik

liczBMI<-function(masa,wzrost){
  bmi<- masa/(wzrost/100)^2
  bmi
}
liczBMI(masa=c(100,200),wzrost=c(200,0))
#[1]  25 Inf

liczBMI <- function(masa,wzrost){
  k <- match(0,wzrost)
  #print(k)
  if(!is.na(k)){
    #bmi <- "dzielenie przez zero"
  }else{
    bmi <- masa/(wzrost/100)^2
  }
  bmi
}
liczBMI(masa=c(100,200),wzrost=c(200,0))
#Błąd w poleceniu 'liczBMI(masa = c(100, 200), wzrost = c(200, 0))':
#  nie znaleziono obiektu 'bmi'

liczBMI2 <- function( ){
  komunikat <- "podaj mase i wzrost oddzielone przecinkiem:"
  odp <- strsplit( readline(komunikat),",")
  print(odp)
  print(odp[[1]])
  wektorOdp <- as.numeric(odp[[1]])
  bmi <- wektorOdp[1] / (wektorOdp[2]/100)^2 
  bmi
}
liczBMI2()
#[[1]]
#[1] "70"  "165"
#[1] "70"  "165"
#[1] 25.71166

liczBMI <- function( ){
  komunikat <- "podaj mase i wzrost oddzielone przecinkiem:"
  wektorOdp <- as.numeric(strsplit( readline(komunikat),",")[[1]])
  bmi <- wektorOdp[1] / (wektorOdp[2]/100)^2 
  bmi
}
liczBMI()