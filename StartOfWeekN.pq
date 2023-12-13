let
  fn = (
    d as date,            //A date in the month.
    n as number,                //Offset, in weeks, from the start (+ve) or end (-ve) of the week.
    firstDayOfWeek as number   //0..6 with 0 being Sunday
  ) as date =>
    
    let
      /*If n is +ve then find the end of the 7-day block before the start of the month,
                    else find the end of the 7-day block after the end of the month.*/
      sevenDaysEnd = 
        if Number.Sign(n) > 0 then
          Date.AddDays(Date.StartOfMonth(d), - 1)
        else
          Date.AddDays(Date.EndOfMonth(d), 7),

      //Find the start of the week in the 7 day block.
      startOfWeek0 = Date.StartOfWeek(sevenDaysEnd, firstDayOfWeek), 

      //Offset by n weeks.
      nthOccurence = Date.AddWeeks(startOfWeek0, n)
    in
      nthOccurence,

  //Function type definition
  fnType = type function (
    d as (
      type date
        meta [
          Documentation.FieldCaption    = "d", 
          Documentation.SampleValues    = { #date(2023,12,25) }, 
          Documentation.FieldDescription = "Any date in the month."
        ]
    ), 
    n as (
      type number
        meta [
          Documentation.FieldCaption     = "n", 
          Documentation.SampleValues     = {1,2,-1},
          Documentation.AllowedValues    = {1,2,3,4,5,-1,-2,-3,-4,-5},
          Documentation.FieldDescription = "Week of month."
        ]
    ), 
    firstDayOfWeek as (
      type number
        meta [
          Documentation.FieldCaption     = "firstDayOfWeek, 0 is Sunday.", 
          Documentation.SampleValues     = {0,1},
          Documentation.AllowedValues    = {0,1,2,3,4,5,6},
          Documentation.FieldDescription = "Day the week starts on."
        ]
    )
  ) as date
    meta [
      Documentation.Name = "StartOfWeekN", 
      Documentation.LongDescription = 
        "Find the start date of the nth week of the month.
        If n is positive, count weeks from the start of the month.
        Otherwise, count weeks from the end of the month.",
    Documentation.Examples = {
        [
          Description = "Find the 2nd Monday of the month", 
          Code        = "StartOfWeekN( #date(2023,12,25), 2, 1 ) ", 
          Result      = "#date(2023, 11, 10)"
        ],
        [
          Description = "Find the last Friday of the month", 
          Code        = "StartOfWeekN( #date(2023,12,25), -1, 5 ) ", 
          Result      = "#date(2023, 12, 29)"
        ]
      }
    ]
in
  //Replace the default type with the custom type.
  Value.ReplaceType(fn, fnType)
