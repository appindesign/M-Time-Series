# M Functions for Time Series
This is the catalogue for my library of custom time series M functions. Each catalogue entry begins with a description of the problem the function solves.

## LinearInterpolation (under construction)
Solve the problem of missing values in a time series by interpolating from neighbouring values.

This is under construction - the bones of the code are here.

## DateTimeSafeLocalNow
Solve the problem of LocalNow being different in the Power BI Service from on your Power BI Desktop.

Consider you have a table of time-series data, collected in your timezone. You want to calculate the age of each reading and so you try a calculation,
- Age = DateTime.LocalNow() - Readings[Datetime]

All works well. Then you publish to the Power BI Service, in a different timezone. For the Service, DateTime.LocalNow() is different from your desktop. Your calculation gives the wrong age. The purpose of this function is to give a Local Now which is always in the same time zone. It reaches out to an api to do so. The api is the [world time api]( https://worldtimeapi.org/) and the timezones are defined by area, location, region as can be found [here](https://worldtimeapi.org/timezones).

## TimeDimension
Solve the problem of creating a time dimension with an origin and interval of your choice.

This function enables you to create the most awkward of datetime dimensions, e.g. starting at 3 minutes and 34 seconds after 1am on the 3rd of March 2020, with an interval of 7 minutes and 30 seconds and continuing for 132 intervals.

First, you tell the function which type of dimension you want: date, time or datetime. Then you tell it the start of the dimension. Next, you tell it when to end. There are two ways of telling it when to end: by giving the end of the dimension; or by giving the number of intervals to include in the dimension. Finally, you give the size of the interval.

The function creates a single column. You may enrich the column analogously to how you enrich a calendar table with day name or month number. Functions such as Time.Hour or Time.StartOfHour may be used (or you add a more complex column such as the nearest fifteen minutes by using the DateTimeRound function, in this library). Or you may wish to add a text column with values “am” or “pm”.

## DateTimeRound
Solve the problem of readings not being exactly at the datetime they're expected.

In the real world the timestamp recorded for a reading often falls on either side of a co-ordinate on the datetime dimension. This “jitter” prevents a relationship being set up between the datetime dimension and the reading.

DateTimeRound rounds a timestamp to a co-ordinate on the datetime dimension, thereby restoring the ability to set up a relationship.

The function needs to be told the timestamp to round, the origin of the datetime dimension, the interval between co-ordinates on the dimension and whether you wish to round up, down or to the nearest co-ordinate. The timestamp and the origin must be of the same type. They may of type time, date or datetime.

## MonthAsM
Solve the problem of month names taking up too much space in a visual.

The function converts a month name to a one letter abbreviation. One, or more, empty characters are added if a month shares its first character with another month.

## StartOfWeekNOfMonth
Solve problems like finding the first Monday of the month, the 2nd Thursday or the last Friday.

The function returns the start date of the nth week of a month. You can specify the start day of the week (e.g. Monday). You can count from the start of the month or from the end of the month.

## FullWeekOfMonth
Solve the problem of returning a number indicating which week of the month a date falls in when weeks are numbered from the first full week of the month.

A date falling in the month but before the first full week is numbered as if it were the last week in the previous month.

## SignificantFigures
Solves the problem of high cardinality in columns of values. This is a common situation in time series data such as sensor readings. High cardinality compromises performance because the data model will be big and DAX calculations will be slower.

The function takes a number and rounds it to your choice of significant figures. Where there is a tie between numbers to round to, a third parameter allows you to specify a rounding mode (as described in Microsoft Learn, [RoundingMode.Type](https://learn.microsoft.com/en-us/powerquery-m/roundingmode-type)). Wikipedia has descriptions of [scientific notation](https://en.wikipedia.org/wiki/Scientific_notation) and [significant figures](https://en.wikipedia.org/wiki/Scientific_notation).
