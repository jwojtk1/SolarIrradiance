
#KCMO <- read.csv("~/Desktop/KCMO/KCMO.csv") #Load data
#KCMO <- KCMO[-c(10177:10200), ] #Remove extra day in leap year
#KCMO <- subset(KCMO, select = -c(Year, Month, Day, Hour, ghr1, ln_ghr, ln_ghr_lag1, ln_ghr_lag24, Model1, Mod1_Prediction, Error)) # Eliminate rows you don't want

#KCMO$global_horz_rad <- ts(KCMO$global_horz_rad, start = c(1987,1), frequency = 8760) #Form time series object with frequency set as the number of hours per year
#plot(KCMO$global_horz_rad, xlab='Year', ylab='Global Horizontal Radiation') #Plot the time series data of ghr

#KCMO_diff <- diff(ifelse(KCMO$global_horz_rad==0,1, KCMO$global_horz_rad), lag = 24)

#plot(KCMO_diff, xlab='Year', ylab='DifferencedLog(Global Horizontal Radiation)') #Differenced data in order to make series stationary for ARIMA model
#Lag set to 24 to model differenced data at the 24-h horizon, not first-differenced

#KCMO_arima <- Arima(KCMO_diff, order = c(1,0,0), seasonal = c(1,1,0))

####################
Data <- read.csv(file.choose(), sep = ',')
library(forecast)
#AData <- ts(start = 1, end = 35064, data = Data$Extraterrestrial_Horizontal_Radiation)

#SCALING
#AData <- ts(start = 1, end = 35064, data = scale(Data$Extraterrestrial_Horizontal_Radiation))

#MINMAX NORMALIZATION
AData <- ts(start = 1, end = 35064, data = (Data$Extraterrestrial_Horizontal_Radiation-min(Data$Extraterrestrial_Horizontal_Radiation))/(max(Data$Extraterrestrial_Horizontal_Radiation)-min(Data$Extraterrestrial_Horizontal_Radiation)))



ArimaFitHere <- Arima(AData, order = c(1,0,0), seasonal = c(1, 1, 0))
ForecastedDataHere <- forecast(ArimaFitHere, 100)
plot(ForecastedDataHere, xlim=c(35000, 35164))
######################

#ARIMA(p,d,q)(P,D,Q,F)
#ARIMA(1,0,0)(1,1,0, F = 24) Differenced at the 24-h horizon, but not first-differenced

