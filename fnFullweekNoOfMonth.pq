let
    //Function definition
    fn = (dateTime as any, optional firstDayOfWeek as number) as number =>
        let
            d = DateTime.Date(dateTime),
            //If no firstDayOfWeek is supplied, apply the default.            
            fdow = if firstDayOfWeek = null then Day.Sunday else firstDayOfWeek,
            //Date of the start of the first full week of the month.            
            fwtm = Date.StartOfWeek(Date.AddDays(Date.StartOfMonth(d), 6), fdow),
            //Date of the start of the first full week of the previous month.
            fwpm = Date.StartOfWeek(Date.AddDays(Date.StartOfMonth(Date.AddMonths(d, -1)), 6), fdow),
            weekNo =
                if d >= fwtm then
                    Number.IntegerDivide(Duration.TotalDays(d - fwtm), 7) + 1
                else
                    Number.IntegerDivide(Duration.TotalDays(d - fwpm), 7) + 1
        in
            weekNo,
    //Function type definition
    fnType = type function (
        dateTime as (
            type any meta [
                Documentation.FieldCaption = "dateTime",
                Documentation.FieldDescription = "A datetime value for which the full-week-of-the-month is determined.",
                Documentation.SampleValues = {#date(2023, 12, 25)},
                //Documentation.AllowedValues = {},
                Documentation.IsMultiline = false,
                Documentation.IsCode = false
            ]
        ),
        optional firstDayOfWeek as (
            type number meta [
                Documentation.FieldCaption = "firstDayOfWeek",
                Documentation.FieldDescription = "A Day value indicating which day should be considered the first day of the week. Allowed values are Day.Sunday, Day.Monday, Day.Tuesday, Day.Wednesday, Day.Thursday, Day.Friday, or Day.Saturday, or 0...6",
                Documentation.SampleValues = {1},
                //Documentation.AllowedValues = {},
                Documentation.IsMultiline = false,
                Documentation.IsCode = false
            ]
        )
    ) as number meta [
        Documentation.Name = "fnFullweekNoOfMonth",
        Documentation.LongDescription = "Returns a number indicating which full week of month a date falls in. 
        Weeks are numbered starting with the first full week of the month (unlike Date.WeekOfMonth).
        If the date falls before the first full week of the month it is numbered as if it were the last week of the previous month.
        firstDayOfWeek defaults to Day.Sunday",
        Documentation.Examples = {
            [
                Description = "Calculate the week number of Monday the 5th of February 2023, where weeks start on Monday",
                Code = "fnFullweekNoOfMonth( #date(2023,2,5), Day.Monday ) ",
                Result = "1"
            ],
            [
                Description = "Calculate the week number of Sunday the 4th of February 2023, where weeks start on Monday",
                Code = "fnFullweekNoOfMonth( #date(2023,2,4), Day.Monday ) ",
                Result = "5"
            ]
        }
    ]
in
    //Make fnType the type for fn.
    Value.ReplaceType(fn, fnType)