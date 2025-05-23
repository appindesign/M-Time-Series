let
    //Function definition
    fn = (num as number) as text =>
        let
            lastTwoDigits = Number.Mod(num, 100),
            lastDigit = Number.Mod(num, 10),
            lastDigitsuffixes = {"th", "st", "nd", "rd"} & List.Repeat({"th"}, 6),
            suffix = if lastTwoDigits >= 11 and lastTwoDigits <= 13 then "th" else lastDigitsuffixes{lastDigit}
        in
            Text.From(num) & suffix,
    //Function type definition
    fnType = type function (
        num as (type number meta [
            Documentation.FieldCaption = "number",
            //Documentation.FieldDescription = "",
            Documentation.SampleValues = {12}
            //Documentation.AllowedValues = {},
            //Documentation.IsMultiline = false,
            //Documentation.IsCode = false
        ])
    ) as number meta [
        Documentation.Name = "fnOrdinalSuffix",
        Documentation.LongDescription = "Add an ordinal suffix to any integer greater than or equal to zero.",
        Documentation.Examples = {
            [
                Description = "1",
                Code = "fnOrdinalSuffix( 1 ) ",
                Result = "1st"
            ],
            [
                Description = "12",
                Code = "fnOrdinalSuffix( 12 ) ",
                Result = "12th"
            ]
        }
    ]
in
    //Make fnType the type for fn.
    Value.ReplaceType(fn, fnType)
