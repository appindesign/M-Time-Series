let
    fn = (dateTime as any) as text =>
        let
            emptyCharacter = Character.FromNumber(8206),
            dayName = Date.DayOfWeekName(dateTime),
            firstLetter = Text.Start(dayName,1),
            D = if dayName="Saturday" or dayName="Tuesday" then firstLetter & emptyCharacter else firstLetter
        in
            D,
    //Function type definition
    fnType = type function (
        dateTime as (
            type any meta [
                Documentation.FieldCaption = "dateTime",
                Documentation.FieldDescription = "date, dateTime or dateTimeZone",
                //Documentation.SampleValues = {10},
                //Documentation.AllowedValues = {},
                Documentation.IsMultiline = false,
                Documentation.IsCode = false
            ]
        )
    ) as text meta [
        Documentation.Name = "fnD",
        Documentation.LongDescription = "Solves the problem of representing a day name by a single letter.
        <p>
        A day name may be too long for a column or row heading.
        The shortest replacement would be a single character.
        However, some days share the same first character.
        This functions adds enough empty characters to the first character to distinguish each day.",
        Documentation.Examples = {
            [
                Description = "Represent Sunday as ""S"".",
                Code = "fnD( #date(2023,12,31) )",
                Result = "S"
            ],
            [
                Description = "Represent Saturday as ""S"".",
                Code = "fnD( #date(2023,1,7) )",
                Result = "S (with 1 empty character following ""S"")."
            ]
        }
    ]   
in
    //Make fnType the type for fn.
    Value.ReplaceType(fn, fnType)