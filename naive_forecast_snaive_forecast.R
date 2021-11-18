library(fpp2)
class(train)
df=train
df$Date <- as.Date(df$Date)
#df
class(df$Date)
df_date=aggregate(df$Weekly_Sales, by=list(df$Date), sum)
colnames(df_date) <- c("Date", "Weekly_Sales")
#normalize above the data 
#Standardize data by using z standardization (X – μ) / σ, where X variable, μ mean and σ is the sd
df_date$Weekly_Sales2 = (df_date$Weekly_Sales - mean(df_date$Weekly_Sales)) / sd(df_date$Weekly_Sales)
#Normalise the values - 
#sd(df_date$Weekly_Sales)
#df_date = as.data.frame(scale(df_date$Weekly_Sales[1:4]))

head(df_date)
#Timeseries

train_ts = ts(df_date$Weekly_Sales2, frequency = 52, start=c(2010,2))

#train_ts2 = ts(df_date$Weekly_Sales, frequency = 52, start=c(2010,2))
#train_ts Plot 
plot(train_ts)
#plot(train_ts2)

#Summary
head(df_date)
summary(df_date)
head(train_ts)
summary(train_ts)
```
Mean for the standardised value is zero that is column Weeklysales2. The mean of standardized values will always be zero, and the standard deviation will always be one. The graph of standardized values will have exactly the same shape as the graph of raw data, but it may be a different size and have different coordinates.

```{r}
#asf function: computes (and by default plots) an estimate of the autocorrelation function of a univariate time series.
Acf(train_ts)
#Acf(train_ts2)
#naive
```
Models -
  ```{r}
#Naive - naive() is simply a wrapper to rwf() for simplicity.  
?naive
naive_forecast <- naive(train_ts,10)
plot(naive_forecast)
```

```{r}
#Snavie - snaive() returns forecasts and prediction intervals from an ARIMA(0,0,0)(0,1,0)m model where m is the seasonal period.
snaive_forecast <- snaive(train_ts,10)
plot(snaive_forecast)
```

```{r}
#stl -Forecasts of STL objects are obtained by applying a non-seasonal forecasting method to the seasonally adjusted data and re-seasonalizing using the last year of the seasonal component.
?stlf
stl_forecast <- stlf(train_ts,10)
plot(stl_forecast)
```

```{r}
#rwf - rwf() returns forecasts and prediction intervals for a random walk with drift model applied to y.
?rwf
rw_forecast <- rwf(train_ts,10)
plot(rw_forecast)
```

```{r}
#meanf - All the forecast value is the average.  5 => last 5 values
mean_forecast <- meanf(train_ts,5)
plot(mean_forecast)
```

```{r}
#ets - Exponential smoothing state space model
ets_forecast <- ets(train_ts)
ets_forecast
```

```{r}
#HoltWinters
```

#holtwinters
?HoltWinter
hw_forecast_level <- HoltWinters(train_ts, beta=FALSE,gamma=FALSE)
hw_forecast_level
