# A Library of Custom M Functions for Time Series
This is a catalogue of custom M functions I built for working on time series data. Each entry begins with a description of the problem the function solves.

## MonthAsM
Solve the problem of month names taking up too much space in a visual.

The function converts a month name to a one letter abbreviation. One, or more, empty characters are added if a month shares its first character with another month.

## StartOfWeekN
Solve problems like finding the first Monday of the month, the 2nd Thursday or the last Friday.

The function returns the start date of the nth week of a month. You can specify the start day of the week (e.g. Monday). You can count from the start of the month or from the end of the month.

## SignificantFigures
Solves the problem of high cardinality in columns of values. This is a common situation in time series data such as sensor readings. High cardinality compromises performance because the data model will be big and DAX calculations will be slower.

The function takes a number and rounds it to your choice of significant figures. Where there is a tie between numbers to round to, a third parameter allows you to specify a rounding mode (as described in [Microsoft Learn, "RoundingMode.Type"](https://learn.microsoft.com/en-us/powerquery-m/roundingmode-type)).

## FunctionTemplate
Solve the problem of creating a documented custom function.

The template contains the core set of documentation meta data. Other meta data, such as allowed values, may be added. The template contains a simple example function to divide a by b. Reference [Adding Function Documentation](https://learn.microsoft.com/en-us/power-query/handling-documentation).
