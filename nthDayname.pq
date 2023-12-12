/* 
Purpose
For the month containing a date "d", return the nth occurence of a day-of-week in the month.
- "Day-of-week" is Sunday...Saturday. 
- Return either the nth from the start (n +ve) or nth from the end (n -ve) of the month.

Method
Find the end-date of the block of 7 days before the start of the month or after the end of month.
Look in the 7 day block to find the one day which is the start of the week.
Add n weeks to that date.
*/

(
    d as date,            //A date in the month.
    n as number,          //Offset, in weeks, from the start (+ve) or end (-ve) of the week.
    dayOfWeek as number   //0..6 with 0 being Sunday
) as date =>

let
    /*If n is +ve then find the end of the 7-day block before the start of the month,
                  else find the end of the 7-day block after the end of the month.*/
    sevenDaysEnd = if Number.Sign(n) > 0 then
        Date.AddDays( Date.StartOfMonth(d), -1)
    else
        Date.AddDays( Date.EndOfMonth(d), 7 ),

    //Find the date of dayOfWeek within the 7 day block.
    weekStarts = Date.StartOfWeek(sevenDaysEnd, dayOfWeek),

    //Offset the date by n weeks.
    nthDayname = Date.AddWeeks(weekStarts, n)
in
    nthDayname
