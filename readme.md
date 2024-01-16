Custom M Functions for Time Series
This is the catalogue for a library custom M functions I built for working on time series data. Each catalogue entry begins with a description of the problem the function solves.

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

The function takes a number and rounds it to your choice of significant figures. Where there is a tie between numbers to round to, a third parameter allows you to specify a rounding mode (as described in [Microsoft Learn, "RoundingMode.Type"](https://learn.microsoft.com/en-us/powerquery-m/roundingmode-type)).
