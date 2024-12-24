# M Functions for Time Series
This is my library of M custom functions for time series data. Each function description describes the problem the function solves.

## Differentiate (under construction but working)
Solve the problem of differentiation.

Supply this function with a table containing a domain and a range and it will add a new column, differenting the range with respect to the domain.

## Integrate (under construction but working)
Solve the problem of integration.

Supply this function with a table containing a domain and a range and it will add a new column, integrating the range from the origin of the domain to the point on the domain, doing so for each point.

<img width="296" alt="Screenshot 2024-05-20 182249" src="https://github.com/appindesign/M-Time-Series/assets/42817224/9c4ef84d-a906-4ad5-aa57-4bad8672a365">

## SmoothWithOutliers
Solve the problem of smoothing a time series which contains outliers.

Supply this function with a table containing a time series and it will add a new column, smoothing the values of the time series. It smooths the values by calculating the median of neighbouring points. You may specify the number of neighbours to use.

![smoothing](https://github.com/appindesign/M-Time-Series/assets/42817224/b3b11705-8133-46f2-8ceb-989916752b83)

## LinearInterpolation (under construction)
Solve the problem of missing values in a time series by interpolating from neighbouring values.

This is under construction - the bones of the code are here.

## DateTimeSafeLocalNow
Solve the problem of LocalNow being different in the Power BI Service from on your Power BI Desktop.

Consider you have a table of time-series data, collected in your timezone. You want to calculate the age of each reading and so you try a calculation,
- Age = DateTime.LocalNow() - Readings[Datetime]

All works well. Then you publish to the Power BI Service, in a different timezone. For the Service, DateTime.LocalNow() is different from your desktop. Your calculation gives the wrong age. The purpose of this function is to give a Local Now which is always in the same time zone. It reaches out to an api to do so. The api is the [world time api]( https://worldtimeapi.org/) and the timezones are defined by area, location, region as can be found [here](https://worldtimeapi.org/timezones).

## fnTimeline
*Problem to be Solved* Solves the problem of creating a timeline of arbitrary interval, start and duration.

With this function you can easily create the most awkward of timelines. For example, a timeline starting at 3 minutes and 34 seconds after 1am on the 3rd of March 2020, with an interval of 7 minutes and 30 seconds and continuing until the end of March.

*Parameters* The function needs to be told the start of the timeline, the interval between co-ordinates and the number of co-ordinates to include. The number of co-ordinates is given directly as a number, or by giving the last co-ordinate to include. The option to give the last co-ordinate makes this function a generalisation of the List.x functions (e.g. List.Datetimes) - they only support giving a number.

*Return Type* The function returns a single-column table, its type is infered from the type of the start co-ordinate.

You may enrich the column with functions such as Time.Hour or Time.StartOfHour. fnRoundTimestamp in this library may be used to add a more complex column - such as allocating a each co-ordinate to a fifteen minute timeslot.

## fnRoundTimestamp
*Problem to be Solved*
1. Solves the problem of readings not being exactly at the datetime they're expected. In the real world the timestamp recorded for a reading often falls on either side of a co-ordinate on the datetime dimension. This “jitter” prevents a relationship being set up between the datetime dimension and the reading. This function rounds a timestamp to a co-ordinate on the datetime dimension. It thereby restores the ability to set up a relationship.
2. Solves the problem of enriching a temporal dimension by assigning each timestamp to a group (e.g. each fifteen minute interval). While functions like Time.StartOfHour exist there is no function like Time.StartOfFifteenMinutePeriod - this function is a general purpose Time.StartOf.

*Parameters* The function needs to be told the origin of the datetime dimension, the interval between co-ordinates on the dimension, the timestamp to round and whether you wish to round up, down or to the nearest co-ordinate. The timestamp and the origin must be of the same type. They may of type time, date, datetime or datetimezone.

## MonthLetter
Solves the problem of month names taking up too much space in a visual.

The function converts a date to a one letter abbreviation. One, or more, empty characters are added if a month shares its first character with another month.

## StartOfWeekNOfMonth
Solve problems like finding the first Monday of the month, the 2nd Thursday or the last Friday.

The function returns the start date of the nth week of a month. You can specify the start day of the week (e.g. Monday). You can count from the start of the month or from the end of the month.

## FullWeekOfMonth
Solve the problem of returning a number indicating which week of the month a date falls in when weeks are numbered from the first full week of the month.

A date falling in the month but before the first full week is numbered as if it were the last week in the previous month.

## SignificantFigures
Solves the problem of high cardinality in columns of values. This is a common situation in time series data such as sensor readings. High cardinality compromises performance because the data model will be big and DAX calculations will be slower.

The function takes a number and rounds it to your choice of significant figures. Where there is a tie between numbers to round to, a third parameter allows you to specify a rounding mode (as described in Microsoft Learn, [RoundingMode.Type](https://learn.microsoft.com/en-us/powerquery-m/roundingmode-type)). Wikipedia has descriptions of [scientific notation](https://en.wikipedia.org/wiki/Scientific_notation) and [significant figures](https://en.wikipedia.org/wiki/Scientific_notation).
