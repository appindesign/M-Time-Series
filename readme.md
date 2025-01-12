# M Functions for Time Series
This is my library of M custom functions for time series data. Each function description describes the problem the function solves.

## Timeline Prepartion
### fnTimeline
*Purpose* Simplifies the problem of creating a timeline of arbitrary interval, start and duration.

With this function you can easily create the most awkward of timelines. For example, a timeline starting at 3 minutes and 34 seconds after 1am on the 3rd of March 2020, with an interval of 7 minutes and 30 seconds and continuing until the end of March. The function generalises existing functions such as List.DateTimes.

*Parameters* 
- `start` The function needs to be told the start of the timeline. The type of  start determines the type of the timeline. The type may be time, date, datetime or datetimezone.
- `interval` The function needs to be told the duration of the interval between co-ordinates. 
- `end` Finally, it needs to be told the number of co-ordinates to include. The number of co-ordinates is given directly as a number, or by giving the last co-ordinate to include. The option to give the last co-ordinate makes this function a generalisation of the List.x functions (e.g. List.DateTimes) - they only support giving a number.

*Return* The function returns a single-column table of the same type as the `start` parameter. The column title is determined by the type of the `start` parameter.

### MonthLetter
Solves the problem of month names taking up too much space in a visual.

The function converts a date to a one letter abbreviation. One, or more, empty characters are added if a month shares its first character with another month.

### StartOfWeekNOfMonth
Solve problems like finding the first Monday of the month, the 2nd Thursday or the last Friday.

The function returns the start date of the nth week of a month. You can specify the start day of the week (e.g. Monday). You can count from the start of the month or from the end of the month.

### FullWeekOfMonth
Solve the problem of returning a number indicating which week of the month a date falls in when weeks are numbered from the first full week of the month.

A date falling in the month but before the first full week is numbered as if it were the last week in the previous month.

## Timestamp Preparation
### fnRoundTimestamp
*Purpose*
1. Mitigates the problem of timestamps not being exactly at co-ordinates on the timeline.
2. Solves the problem of assigning a timestamp to a time interval, generalising functions such Time.StartOfHour.

In the real world readings often fall either side of a co-ordinate on the timeline<sup>1</sup>. This function rounds a timestamp to a co-ordinate. Without doing this you could not create a relationship between the co-ordinates on the timeline and the timestamps of the readings. 

Another use is to allocate a timestamp to a time interval - some such functions already exist (e.g. Time.StartOfHour allocates a timestamp to an hour). This function generalises the existing functions. For example you may wish to allocate a timestamp to the start of a fifteen minute period.

<sup>1</sup>This may be due to a fixed difference in reading time between the sensor and co-ordinates on the timeline, or random "jitter" or "drift" in reading times, or a combination of all of these.

*Parameters* The function needs to be told the origin of the timeline, the interval between co-ordinates on the timeline, the timestamp to round and whether you wish to round up, down or to the nearest co-ordinate. The timestamp and the origin must be of the same type. They may of type time, date, datetime or datetimezone.

## Values Preparation
### fnSignificantFigures
*Purpose*
Solves the problem of high cardinality in a columns of values.

High cardinality creates a large data model and makes DAX calculations slower. This is a common situation in time series data such as sensor readings. Rounding reduces cardinality.

I have seen examples of readings recorded to 6 figures when only 3 are of significance. Rounding to 3 significant figures would reduce cardinality to a maximum of 1,000 from a maximum of 1,000,000.

*Parameters*
The function needs to be told the number to round and the number of significant figures to round to. A third parameter allows you to specify a rounding mode (as described in Microsoft Learn, [RoundingMode.Type](https://learn.microsoft.com/en-us/powerquery-m/roundingmode-type)). Wikipedia has descriptions of [scientific notation](https://en.wikipedia.org/wiki/Scientific_notation) and [significant figures](https://en.wikipedia.org/wiki/Scientific_notation).

## Values Enrichment
### fnSeasonalAverage
*Purpose*
Solves the problem of calculating the average for each season in a time series.

Given a time series of timestamps and reading values (with no gaps in the timestamps column), the function will calculate the average for each season. The output will be a list with each value being a season average.

*Parameters*
The function needs to be given the values column from the time series and it needs to be told the number of values per season.

*Return*
The function returns a list of the same length as the values column but each value being a season average.

### Differentiate (under construction but working)
Solve the problem of differentiation.

Supply this function with a table containing a domain and a range and it will add a new column, differenting the range with respect to the domain.

### Integrate (under construction but working)
Solve the problem of integration.

Supply this function with a table containing a domain and a range and it will add a new column, integrating the range from the origin of the domain to the point on the domain, doing so for each point.

<img width="296" alt="Screenshot 2024-05-20 182249" src="https://github.com/appindesign/M-Time-Series/assets/42817224/9c4ef84d-a906-4ad5-aa57-4bad8672a365">

### SmoothWithOutliers
Solve the problem of smoothing a time series which contains outliers.

Supply this function with a table containing a time series and it will add a new column, smoothing the values of the time series. It smooths the values by calculating the median of neighbouring points. You may specify the number of neighbours to use.

![smoothing](https://github.com/appindesign/M-Time-Series/assets/42817224/b3b11705-8133-46f2-8ceb-989916752b83)

### LinearInterpolation (under construction)
Solve the problem of missing values in a time series by interpolating from neighbouring values.

This is under construction - the bones of the code are here.

## Utilities
### fnEvenCentredAverage
*Purpose* Solves the problem of calculating a centred average for an even number (n) of items.

Given an ordered list with an even number of items, there is no "centre" item. This presents a problem if you wish to calculate a centred average. A suitable solution starts by creating an odd list, of n+1 items, using the n/2 items before the item, the item itself and the n/2 items after the item. Passing such a list to this function will result in a centred average being calculated as 1/2 x the first item plus 1/2 x the last item plus the sum of the other items, all of this then being divided by n.

*Parameters* A single parameter of an odd list of null numbers is required.

*Return* A number which is the centred average of the list.

## Other
### DateTimeSafeLocalNow
Solve the problem of LocalNow being different in the Power BI Service from the source of your data.

Consider you have a table of time-series data, collected in your timezone. You want to calculate the age of each reading and so you try a calculation,
- Age = DateTime.LocalNow() - Readings[Datetime]

All works well. Then you publish to the Power BI Service, in a different timezone. For the Service, DateTime.LocalNow() is different from your desktop. Your calculation gives the wrong age. The purpose of this function is to give a Local Now which is always in the same time zone. It reaches out to an api to do so. The api is the [world time api]( https://worldtimeapi.org/) and the timezones are defined by area, location, region as can be found [here](https://worldtimeapi.org/timezones).
