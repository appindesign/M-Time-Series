let
    //Function definition
    fn = (dt as any, month as number, day as number) as any =>
        let
            inYearStart = Date.AddDays(Date.AddMonths(Date.StartOfYear(dt), month-1), day-1),
            startOfYear = if dt < inYearStart then Date.AddYears(inYearStart, -1) else inYearStart
        in
            startOfYear,
    //Function type definition
    fnType = type function (
        dt as (type any meta [
            Documentation.FieldCaption = "datetime"
            //Documentation.FieldDescription = "Numerator", //This is not displayed.
            //Documentation.SampleValues = {}, //Only the first sample value is displayed.
            //Documentation.AllowedValues = {},
            //Documentation.IsMultiline = false,
            //Documentation.IsCode = false
        ]),
        month as (type number meta [
            Documentation.FieldCaption = "month",
            //Documentation.FieldDescription = "Denominator", //This is not displayed.
            //Documentation.SampleValues = {}, //Only the first sample value is displayed.
            Documentation.AllowedValues = {1..12}
            //Documentation.IsMultiline = false,
            //Documentation.IsCode = false
        ]),
        day as (type number meta [
            Documentation.FieldCaption = "day",
            //Documentation.FieldDescription = "Denominator", //This is not displayed.
            //Documentation.SampleValues = {}, //Only the first sample value is displayed.
            Documentation.AllowedValues = {1..31}
            //Documentation.IsMultiline = false,
            //Documentation.IsCode = false
        ])
    ) as number meta [
        Documentation.Name = "fnStartOfYear",
        Documentation.LongDescription = "Finds the start of the current year, where the year starts on ""month"" and ""day""",
        Documentation.Examples = {[
            Description = "Find the start of the current year if the date is 3rd Jun 2025 and the year starts on 30th Sep.",
            Code = "fnStartOfYear(#date(2025,6,3), 9, 30",
            Result = "#date(2024,9,30)"
        ]}
    ]
in
    //Make fnType the type for fn.
    Value.ReplaceType(fn, fnType)