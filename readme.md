# M Functions for Time Series
This is my library of M custom functions for time series data. Each function description describes the problem the function solves, its parameters and the value it returns.

## Timeline Prepartion
### fnTimeline
*Purpose* Simplifies the problem of creating a timeline of arbitrary interval, start and duration.

With this function you can easily create the most awkward of timelines. For example, a timeline starting at 3 minutes and 34 seconds after 1am on the 3rd of March 2020, with an interval of 7 minutes and 30 seconds and continuing until the end of March. The function generalises existing functions such as List.DateTimes.

*Parameters* 
- `start` The function needs to be told the start of the timeline. The type of  start determines the type of the timeline. The type may be time, date, datetime or datetimezone.
- `interval` The function needs to be told the duration of the interval between co-ordinates. 
- `end` Finally, it needs to be told the number of co-ordinates to include. The number of co-ordinates is given directly as a number, or by giving the last co-ordinate to include. The option to give the last co-ordinate makes this function a generalisation of the List.x functions (e.g. List.DateTimes) - they only support giving a number.

*Return* The function returns a single-column table. The column type is the type of the `start` parameter. The column title is the type of the `start` parameter.

## Timeline and Timestamp Enrichment
### fnM
*Purpose* Solves the problem of representing a month name by a single letter.

A month name may be too long for a column or row heading. The shortest replacement would be a single character. However, some months share the same first character. This functions adds enough empty characters to the first character to distinguish each month.

*Parameters*
- `dateTime` The dateTime to be represented by a single letter for its month. The dateTime may be of type date, datetime or datetimezone.

*Return* The furnction returns a single visible letter (plus empty characters as required to distinguish it from months starting with the same letter). The return type is text.

### fnD
*Purpose* Solves the problem of representing a day name by a single letter.

A day name may be too long for a column or row heading. The shortest replacement would be a single character. However, some days share the same first character. This functions adds enough empty characters to the first character to distinguish each day.

*Parameters*
- `dateTime` The dateTime to be represented by a single letter for its day. The dateTime may be of type date, datetime or datetimezone.

*Return* The furnction returns a single visible letter (plus empty characters as required to distinguish it from days starting with the same letter). The return type is text.

### fnFullweekNoOfMonth
*Purpose* Solves the problem of finding the week number of the month a date lies in, when weeks are numbered from the first full week of the month.

A date falling in the month but before the first full week is numbered as if it were the last week in the previous month.

*Parameters*
- `dateTime` The date for which the week number is to be found. The type may be date, datetime or datetimezone.
- `firstDayOfWeek` The day weeks are considered to start on, e.g. Day.Sunday.

*Return* The function returns the week number as type number.

### fnNthDaynameOfMonth
*Purpose* Solves the problem of finding the date of the Nth occurence of a day name in a Month.

This function can solve problems like finding the first Monday of the month or the 2nd Thursday. It can also count from the end of the month and find dates like the last Friday of a month.

*Parameters*
- `dateTime` A date in the month. dateTime may be of type date, datetime or datetimezone.
- `n` The occurence of the day to find. If n is positive the function counts from the start of the month. If n is negative the function counts from the end of the month.
- `day` The day you wish to find the occurence of e.g. Day.Friday.

*Return* The function returns the date of the nth occurence of `day` as type date, datetime or datetimezone.

## Timestamp Preparation
### fnRoundTimestamp
*Purpose*
1. Mitigates the problem of timestamps not being exactly at co-ordinates on the timeline.
2. Solves the problem of assigning a timestamp to a time interval, generalising functions such Time.StartOfHour.

In the real world readings often fall either side of a co-ordinate on the timeline<sup>1</sup>. This function rounds a timestamp to a co-ordinate. Without doing this you could not create a relationship between the co-ordinates on the timeline and the timestamps of the readings. 

Another use is to allocate a timestamp to a time interval - some such functions already exist (e.g. Time.StartOfHour allocates a timestamp to an hour). This function generalises the existing functions. For example you may wish to allocate a timestamp to the start of a fifteen minute period.

<sup>1</sup>This may be due to a fixed difference in reading time between the sensor and co-ordinates on the timeline, or random "jitter" or "drift" in reading times, or a combination of all of these.

*Parameters* 
- `timestamp` The timestamp to round.
- `origin` The function needs to be told the origin of the timeline.
- `interval` The interval between co-ordinates on the timeline.
- `roundingMode`  The rounding mode - up, down or nearest (as described in Microsoft Learn, [RoundingMode.Type](https://learn.microsoft.com/en-us/powerquery-m/roundingmode-type)).

*Return* The function returns the rounded timestamp as type date, datetime or datetimezone.

## Values Preparation
### fnSignificantFigures
*Purpose*
Solves the problem of large, unpeformant, datasets.

High cardinality creates a large data model and makes DAX calculations slower. This is a common situation in time series data such as sensor readings where the range of readings is high. Rounding reduces cardinality.

I have seen examples of readings recorded to 6 figures when only 3 are of significance. Rounding to 3 significant figures would reduce cardinality to a maximum of 1,000 from a maximum of 1,000,000.

Wikipedia has descriptions of [scientific notation](https://en.wikipedia.org/wiki/Scientific_notation) and [significant figures](https://en.wikipedia.org/wiki/Scientific_notation).

*Parameters*
- `x` The number to be rounded.
- `significantFigures` The number of significant digits to round to.
- `roundingMode` The rounding mode - up, down or nearest (as described in Microsoft Learn, [RoundingMode.Type](https://learn.microsoft.com/en-us/powerquery-m/roundingmode-type)).

*Return* The function returns the rounded value of `x` as type number.

## Values Enrichment
### fnWindowCalculation
*Purpose* Solves the problem of calculating, fast, over a moving window, for example moving means.

*Parameters*
- `lst` The list over which the calculation is to be executed.
- `before` The number of items to be included before the current list position.
- `after` The number of items to be included after the current list position.
- `calculation` The function to be evaluated over each window.

*Return* The function returns a list with the result of the calculation for each window. The return type is list.

### fnSeasonalAverage
*Purpose*
Solves the problem of calculating the average for each season in a time series.

Given a time series of timestamps and reading values (with no gaps in the timestamps column), the function will calculate the average for each season. The output will be a list with each value being a season average.

*Parameters*
- `lst` The ordered list of values from the time series.
- `seasons` The number of values in each seasons.

*Return*
The function returns a list of the same length as the values column but each value being a season average. The return type is list.

## Utilities
### fnTableType
*Purpose* Solves the problems of 
1. Getting a table's type.
2. Getting a table's type if it were extended with additional columns.

*Parameters*
- `table` The table for which the type is to be found (or to which additional columns are to be added).
- `additionalNames` A list of the names of the additional columns.
- `additionalTypes` A list of the types of the additional columns.

*Return* The function returns the table type of `table` as a table type.

### fnTableAddLists
*Purpose* Solves the problem of adding to a table lists as new columns.

*Parameters*
- `tbl` The table to which the lists are to be added.
- `lists` The lists.
- `names` The names of the new columns.
- `types` The types of the new columns.

The function calls fnTableType to construct the table type of the new table based on the table type of tbl and the types of the new columns.

*Return* The function returns `tbl` extended with a column for each list. The extended columns take the types specified in `types`.

### fnOrdinalSuffix
*Purpose* Solves the problem of adding a suffix to a number to make it ordinal. For example 1 -> 1st, 12 -> 12th.

*Parameters*
- `num` The number to be given the suffix. Must be an integer greater than or equal to zero.

*Return* The function returns 'num' with an ordinal suffix added.

### fnStartOfFY
*Purpose* Solves the problem of finding the start of a timestamp's financial year, given the financial year starts on `month` and `day`.

*Parameters*
- `datetime` The date for which you wish to find the start of the financial year. dateTime may be of type date, datetime or datetimezone.
- `month` The calander month number of the start of the financial year.
- `day` The day number of the start of the financial year.

*Return* The function returns the start of `datetime`'s financial year. The returned value is the same type as `datetime`.
