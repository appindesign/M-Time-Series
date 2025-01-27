let
    //Function defintion
    fn = (d as any, n as number, firstDayOfWeek as number) as any =>
        let
            /*If n is +ve 
              then find the end of the 7-day block before the start of the month,
              else find the end of the 7-day block after the end of the month.*/
            sevenDaysEnd =
                if Number.Sign(n) > 0 then
                    Date.AddDays(Date.StartOfMonth(d), -1)
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
            type any meta [
                Documentation.FieldCaption = "d",
                Documentation.FieldDescription = "Any date in the month.",
                Documentation.SampleValues = {#date(2023, 12, 25)}
            ]
        ),
        n as (
            type number meta [
                Documentation.FieldCaption = "n",
                Documentation.FieldDescription = "Week of month.",
                Documentation.SampleValues = {1, 2, -1},
                Documentation.AllowedValues = {1, 2, 3, 4, 5, -1, -2, -3, -4, -5}

            ]
        ),
        firstDayOfWeek as (
            type number meta [
                Documentation.FieldCaption = "firstDayOfWeek, 0 is Sunday.",
                Documentation.FieldDescription = "Day the week starts on.",
                Documentation.SampleValues = {0, 1},
                Documentation.AllowedValues = {0, 1, 2, 3, 4, 5, 6}
            ]
        )
    ) as any meta [
        Documentation.Name = "fnNthDaynameOfMonth",
        Documentation.LongDescription = "Find the start date of the nth week of the month.
        If n is positive, count weeks from the start of the month.
        Otherwise, count weeks from the end of the month.",
        Documentation.Examples = {
            [
                Description = "Find the 2nd Friday of the month",
                Code = "fnNthDaynameOfMonth( #date(2023,12,25), 2, Day.Friday ) ",
                Result = "#date(2023, 12, 8)"
            ],
            [
                Description = "Find the last Friday of the month",
                Code = "fnNthDaynameOfMonth( #date(2023,12,25), -1, Day.Friday ) ",
                Result = "#date(2023, 12, 29)"
            ]
        }
    ]
in
    //Apply fnType as the type for fn.
    Value.ReplaceType(fn, fnType)