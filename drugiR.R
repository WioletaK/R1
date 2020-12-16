x<-1:100
x

mojVector <- vector("numeric",10)
mojVector

mojVector <- 1:20
mojVector
class(mojVector)

mojVector <- c(1,2,3,4,5)
class(mojVector)

mojVector <- c( 1,2,3.5,FALSE)
class(mojVector)

mojVector <- c(0,1,0,TRUE,FALSE)
class(mojVector)
mojVector <- as.logical(mojVector)
mojVector
class(mojVector)
print(as.character(mojVector))

mojaLista <- list("1",2,3,TRUE,FALSE)
mojaLista

list(c("jeden","dwa","trzy"),1:3,c(1+2i,2+1i))

mojaMacierz <- matrix(nrow=10,ncol=9)
mojaMacierz
dim(mojaMacierz)

mojaMacierz <- matrix(1:90,nrow=10,ncol=9)
mojaMacierz

dim(mojaMacierz) <- c(9,10)
mojaMacierz
dim(mojaMacierz) <- c(10,9)
mojaMacierz

mojaMacierz[,2]
mojaMacierz[2,]
mojaMacierz[2,2]

pierwszy <- c(1,2,3,4,5)
drugi <- c(6,7,8,9,10)
cbind(pierwszy,drugi)
rbind(pierwszy,drugi)

drugi <- c(6,7,8,9,10,11,12)
rbind(pierwszy,drugi)
cbind(pierwszy,drugi)

plec <- factor(c("kobieta","mezczyzna","mezczyzna","mezczyzna","kobieta"))
plec
unclass(plec)

plec <-
  factor(c("kobieta","mezczyzna","mezczyzna","mezczyzna","kobieta"),c("mezczyzna","kobieta"))
plec
unclass(plec)

brakujace <- vector("integer",5)
brakujace
brakujace[2:4]<-NA
brakujace
is.na(brakujace)
w <- c(1267,345,NA,NA,2342,435345,76456,23423,NA,22432,NA,2)
missing <- is.na(w)
missing
!missing
w[!missing]

vec <- c(1267,345,NA,NA,2342,435345,76456,23423,NA,22432,NA,2)
bezBrakujacych <- complete.cases(vec)
bezBrakujacych
vec[bezBrakujacych]

mojaRamkaDanych<-data.frame(index=1:5,plec=factor(c("kobieta","mezczyzna","mezczyzna","mezczyzna","kobieta"),
                                 c("mezczyzna","kobieta")))
names(mojaRamkaDanych)


macierz<-matrix(1:10,nrow=5,ncol=5)
macierz
names(macierz)
dimnames(macierz)<- list(c(1,2,3,4,5),c("a","b","c","d","e"))
macierz

mojVector <- c(1,2,0,4,5)
mojVector[1]
mojVector[1:10]
mojVector[ mojVector < 2]


print("Podaj nazwy kolumn oddzielone spacja:")
columns <- readline("kolumny: ")
nazwy_kolumn <- strsplit(columns, " ")
class(columns)
class(nazwy_kolumn)

nazwy_kolumn
unlist(nazwy_kolumn)
class(unlist(nazwy_kolumn))
class(nazwy_kolumn)
?t
t(unlist(nazwy_kolumn))
t(nazwy_kolumn[[1]])

komunikat <- "Podaj liczbe wierszy: "
ile <- as.integer(readline(komunikat))
