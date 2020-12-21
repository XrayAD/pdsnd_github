library("ggplot2")
library(stringr)
chic = read.csv('chicago.csv')
new = read.csv('new-york-city.csv')
wash = read.csv('washington.csv')

#Question 1 - What is the average ride time for all renters accross the cities?  

#First lets's look at the Chicago data
ggplot(aes(x = Trip.Duration/60), data = chic) +
  geom_histogram(binwidth = .33, color = "blue") +
  coord_cartesian(xlim = c(0,60)) +
  labs(title = "Trip Duration Plot for Chicago", x = "Trip Duration in Minutes", y = "Trip Count")

mean(chic$Trip.Duration/60)
median(chic$Trip/60)

#Now the New york data
ggplot(aes(x = Trip.Duration/60), data = new) +
  geom_histogram(binwidth = .33, color = "blue") +
  coord_cartesian(xlim = c(0,60)) +
  labs(title = "Trip Duration Plot for New York", x = "Trip Duration in Minutes", y = "Trip Count")

mean(new$Trip.Duration/60)
median(new$Trip/60)

#and finally the Washington Data
ggplot(aes(x = Trip.Duration/60), data = wash) +
  geom_histogram(binwidth = .33, color = "blue") +
  coord_cartesian(xlim = c(0,60)) +
  labs(title = "Trip Duration Plot for Washington", x = "Trip Duration in Minutes", y = "Trip Count")

mean(wash$Trip.Duration/60)
median(wash$Trip/60)

#We see that the data for each graph is right skewed, with means much higher than median.
# For chicago: mean 15.6, median 11.2. New York: mean 14.9, median 10.1.
#Washington: mean 20.6, median 11.7.  In all cases longer riders are dragging up the mean.
#Taking median as the better measure of average we see that Washington has the longest rides,
#followed by Chicago and then New York, all less than 2 minutes apart.  The trend is the same in means.


#Question 2 - Do subsribers or customers average longer rides in New York?
# Now I want to compare the trip duration for subscribers versus customers in each New York,
#to see if subsribers have longer trip durations than customers

# Here a boxplot will show the medians and data distributions for each group
ggplot(subset(new, !(new$User.Type==""))) +
  geom_boxplot(aes(x = User.Type, y = Trip.Duration/60)) +
  coord_cartesian(ylim = c(0,60)) +
  labs(title = "BoxPlots For Trip During by Customer Type in New York", x = "Customer Type", y  = "Trip Duration in Minutes")

#it seems customers take on average much longer rides (a median about 7 minutes higher).  
#This would indicate customers perhaps tour the city while subscribers have a short
#commute in mind, leading them to subscribe.


#Questions 3 - What are the most common start times for rides in Chicago?
#Now I want to look at a graph of start times in Chicago to see what times are most
#popular to rent a bike.  It would also be also nice to see the popular end times 
#to know when bikes are freeing up.


# Plot for Start time, extracting hour from start time
ggplot(data = chic, aes(x = as.numeric(str_sub(chic$Start.Time, -8, -7)))) +
  geom_histogram(binwidth = 1, color = "black", fill ="blue") +
  labs(title = "Start Time For Renters in Chicago", x = "Hour", y = "Count")
# Plot for End time, extracting hour
ggplot(data = chic, aes(x = as.numeric(str_sub(chic$End.Time, -8, -7)))) +
  geom_histogram(binwidth = 1, color = "black", fill  = "red") +
  labs(title = "End Time For Renters in Chicago", x = "hour", y= "Count")


#looking at the output, the start time graph is almost identical to end time.  
# This is reasonable as we partitioned by hour and the mean ride time is much
# less than one hour.  So bikes free up rougly the same amount as they get
# used hourly

