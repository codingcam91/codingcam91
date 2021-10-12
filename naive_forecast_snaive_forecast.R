read.csv('features.csv')
read.csv('stores.csv')
read.csv('train_2.csv')
foo_ts = ts(train$Weekly_Sales, frequency = 52, start =c(2010,6))


# Naive Forecast
naive_forecast <- naive(foo_ts,52)
plot(naive_forecast)

# Lets try Seasonal Naive
snaive_forecast <- snaive(foo_ts,52)
plot(snaive_forecast)


