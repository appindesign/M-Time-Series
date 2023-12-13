// Query1
/* 
Purpose
For the month containing a date "d", return the nth occurence of a day-of-week in the month.
- "Day-of-week" is Sunday...Saturday. 
- Return either the nth from the start (n +ve) or nth from the end (n -ve) of the month.

Method
Find the end-date of the block of 7 days before the start of the month or after the end of the month.
Look in the 7 day block to find the start date of the week which starts on day-of-week.
Add n weeks to that date.
*/

let
  nthDayname = (
    d as date,            //A date in the month.
    n as number,          //Offset, in weeks, from the start (+ve) or end (-ve) of the week.
    dayOfWeek as number   //0..6 with 0 being Sunday
  ) as date =>
    
    let
      /*If n is +ve then find the end of the 7-day block before the start of the month,
                    else find the end of the 7-day block after the end of the month.*/
      sevenDaysEnd = 
        if Number.Sign(n) > 0 then
          Date.AddDays(Date.StartOfMonth(d), - 1)
        else
          Date.AddDays(Date.EndOfMonth(d), 7),

      //Find the date of the week startinng on day-of-week within the 7 day block.
      weekStarts = Date.StartOfWeek(sevenDaysEnd, dayOfWeek), 

      //Offset the date by n weeks.
      nthOccurence = Date.AddWeeks(weekStarts, n)
    in
      nthOccurence,

  //Function type definition
  nthDaynameType = type function (
    d as (
      type date
        meta [
          Documentation.FieldCaption    = "d", 
          Documentation.SampleValues    = { #date(2023,12,25) }, 
          Documenation.FieldDescription = "Date in month"
        ]
    ), 
    n as (
      type number
        meta [
          Documentation.FieldCaption     = "n", 
          Documentation.SampleValues     = {1, 2, - 1}, 
          Documentation.FieldDescription = "Week of month"
        ]
    ), 
    dayOfWeek as (
      type number
        meta [
          Documentation.FieldCaption     = "dayOfWeek", 
          Documentation.SampleValues     = {0, 1}, 
          Documentation.FieldDescription = "Day of week"
        ]
    )
  ) as date
    meta [
      Documentation.Name = "nthDayname", 
      Documentation.LongDescription = "Find the date of the nth occurence of 'dayOfWeek' in the month containing date 'd'. If n is positive, n is counted from the start of the month. If n is negative, n is counted from the end of the month.", 
      Documentation.Examples = {
        [
          Description = "Find the 2nd Monday of the month", 
          Code        = "nthDayname( #date(2023,12,25), 2, 1 ) ", 
          Result      = "#date(2023, 11, 10)"
        ],
        [
          Description = "Find the last Friday of the month", 
          Code        = "nthDayname( #date(2023,12,25), -1, 5 ) ", 
          Result      = "#date(2023, 12, 29)"
        ]
      }
    ]
in
  //Replace the default type with the custom type.
  Value.ReplaceType(nthDayname, nthDaynameType)
