/*
Purpose
For the month containing a date d, return the nth occurence of a day-of-week in the month.
Returns either the nth from the start or nth from the end of the month.

Parameters
The day of week is given as a number 0..6 with 0 being Sunday.
n is positive to count from the beginning of the month.
n is negative to count from the end of the month.

Method
Find the end-date of a block of 7 days before the start of the month or after the end of month.
Find the date of day-of-week in that block to use as a starting reference.
Add n weeks to that date.
*/

(
    d as date,
    n as number,
    dayOfWeek as number
) as date =>

let
    sevenDaysEnd = if Number.Sign(n) > 0 then
        Date.AddDays( Date.StartOfMonth(d), -1)
    else
        Date.AddDays( Date.EndOfMonth(d), 7 ),
    referenceDate = Date.StartOfWeek(sevenDaysEnd, dayOfWeek),
    result = Date.AddWeeks(referenceDate, n)
in
    result
