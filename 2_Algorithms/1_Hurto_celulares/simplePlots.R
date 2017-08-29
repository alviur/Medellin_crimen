#######################################################################################
#
#
#
#
#######################################################################################



## Read data
dat2010 = read.csv("/home/lex/Desktop/Medellin_crime/1_Datasets/1_Hurto_celulares/Delito_Hurto_Celulares2010.csv", header = TRUE)
dat2011 = read.csv("/home/lex/Desktop/Medellin_crime/1_Datasets/1_Hurto_celulares/Delito_Hurto_Celulares2011.csv", header = TRUE)
dat2012 = read.csv("/home/lex/Desktop/Medellin_crime/1_Datasets/1_Hurto_celulares/Delito_Hurto_Celulares2012.csv", header = TRUE)
dat2013 = read.csv("/home/lex/Desktop/Medellin_crime/1_Datasets/1_Hurto_celulares/Delito_Hurto_Celulares2013.csv", header = TRUE)
dat2014 = read.csv("/home/lex/Desktop/Medellin_crime/1_Datasets/1_Hurto_celulares/Delito_Hurto_Celulares2014.csv", header = TRUE)
dat2015 = read.csv("/home/lex/Desktop/Medellin_crime/1_Datasets/1_Hurto_celulares/Delito_Hurto_Celulares2015.csv", header = TRUE)
dat2017 = read.csv("/home/lex/Desktop/Medellin_crime/1_Datasets/1_Hurto_celulares/Delito_Hurto_Celulares2017.csv", header = TRUE)

dat<-dat2010
## Remove hour information
for (index in 1:nrow(dat)){
  
  dat$Fecha <- as.character(dat$Fecha)
  dateTemp<-as.character(dat[index,1]);
  
  if(nchar(dateTemp)>10){
    
    
    dat[index,1]<-substr(dateTemp, 1, 10)
    print(dat[index,1])
    
  }
}

## Arrange by date
dat[order(as.Date(dat$Fecha, format="%d/%m/%Y")),];

## Get data from Antioquia deparment
antioquia<-dat[dat$DEPARTAMENTO=="ANTIOQUIA",]

## Get unique dates
dayOfIncident <- antioquia$FECHA[!duplicated(antioquia$Fecha)]

## Get votes
numInc<-data.frame(table(antioquia$FECHA))

## Plot raw data
a<-numInc[order(as.Date(numInc$Var1, format="%d/%m/%Y")),];
plot(a$Freq,type="l")


rawSerie<-ts(numInc$Freq,frequency = 30)
## Cleaning seasonality
