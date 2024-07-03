let
    fn = (dt as any) as text =>
        let
            emptyCharacter = Character.FromNumber(8206),
            monthNumber = Date.Month(dt),
            translations = {
                "J",
                "F",
                "M",
                "A",
                "M" & Text.Repeat(emptyCharacter, 1),
                "J" & Text.Repeat(emptyCharacter, 1),
                "J" & Text.Repeat(emptyCharacter, 2),
                "A" & Text.Repeat(emptyCharacter, 1),
                "S",
                "O",
                "N",
                "D"
            },
            M = translations{monthNumber - 1}
        in
            M,
    //Function type definition
    fnType = type function (dt as (type any meta [
        Documentation.FieldCaption = "dt"
    ])) as text meta [
        Documentation.Name = "MonthLetter",
        Documentation.LongDescription = "Solves the problem of a month name taking up too much space in a visual.
        <p>
        A month name may be too long for a column or row heading.
        The shortest replacement would be a single character.
        However, some months share the same first character.
        Therefore, add to the first character enough empty characters to distinguish each month.
        <p>
        For the empty character I use unicode character hex 200E, decimal 8206.",
        Documentation.Examples = {
            [
                Description = "Find the representation for January",
                Code = "MonthLetter( #date(2024,1,1) )",
                Result = "J"
            ],
            [
                Description = "Find the representation for June",
                Code = "MonthLetter( #date(2024,6,1) )",
                Result = "J (with 1 empty character following ""J"")"
            ],
            [
                Description = "Abbreviate the dates in a date column",
                Code = "= Table.TransformColumns( #""Previous Step"", {{""Date"", each MonthLetter(_), type text}} )",
                Result = "The dates in the ""Date"" column are replaced by an abbreviation of the month name."
            ],
            [
                Description = "Add a column abbreviating the dates in the ""Date"" column",
                Code = "= Table.AddColumn( #""Previous Step"", ""M"", each MonthLetter(_[Date]), type text )",
                Result = "A new column, M, with abbreviated month names."
            ]
        }
    ]
in
    //Replace the default type with the custom function type.
    Value.ReplaceType(fn, fnType)
