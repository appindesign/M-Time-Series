# M Functions for Time Series
This is the catalogue for my library of custom M functions for time series. Each catalogue entry begins with a description of the problem the function solves.

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
