let
    fn = (dateTime as any) as text =>
        let
            emptyCharacter = Character.FromNumber(8206),
            monthNumber = Date.Month(dateTime),
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
    fnType = type function (
        dateTime as (
            type any meta [
                Documentation.FieldCaption = "dateTime",
                Documentation.FieldDescription = "Numerator",
                Documentation.SampleValues = {10},
                //Documentation.AllowedValues = {},
                Documentation.IsMultiline = false,
                Documentation.IsCode = false
            ]
        )
    ) as text meta [
        Documentation.Name = "fnM",
        Documentation.LongDescription = "Solves the problem of representing a month name by a single letter.
        <p>
        A month name may be too long for a column or row heading.
        The shortest replacement would be a single character.
        However, some months share the same first character.
        This functions adds enough empty characters to the first character to distinguish each month.
        <p>
        For the empty character I use unicode character hex 200E, decimal 8206.",
        Documentation.Examples = {
            [
                Description = "Represent January as ""J"".",
                Code = "fnM( #date(2024,1,1) )",
                Result = "J"
            ],
            [
                Description = "Represent June as ""J"".",
                Code = "fnM( #date(2024,6,1) )",
                Result = "J (with 1 empty character following ""J"")."
            ],
            [
                Description = "Represent the dates in a column by a single letter.",
                Code = 
"Table.TransformColumns(
    Table.FromRecords({
        [Month = #date(2025, 1, 1)],
        [Month = #date(2025, 2, 1)],
        [Month = #date(2025, 3, 1)],
        [Month = #date(2025, 4, 1)],
        [Month = #date(2025, 5, 1)],                                 
        [Month = #date(2025, 6, 1)]
        }, 
        type table [Month = date]
    ),
    {{""Month"", each fnM(_), type text}}
)",
                Result = 
"Table.FromRecords({
    [Month = ""J""],
    [Month = ""F""],
    [Month = ""M""],
    [Month = ""A""],
    [Month = ""M""],                               
    [Month = ""J""]
    }, 
    type table [Month = text]
)"
            ],
            [
                Description = "Add a column representing the dates in the ""Date"" column by a single letter.",
                Code = 
"Table.AddColumn(
    Table.FromRecords({
        [Month = #date(2025, 1, 1)],
        [Month = #date(2025, 2, 1)],
        [Month = #date(2025, 3, 1)],
        [Month = #date(2025, 4, 1)],
        [Month = #date(2025, 5, 1)],                                 
        [Month = #date(2025, 6, 1)]
        },
        type table [Month = date]
    ),
    ""M"",
    each fnM([Month]), type text
)",
                Result = 
"Table.FromRecords({
        [Month = #date(2025, 1, 1), M=""J""],
        [Month = #date(2025, 2, 1), M=""F""],
        [Month = #date(2025, 3, 1), M=""M""],
        [Month = #date(2025, 4, 1), M=""A""],
        [Month = #date(2025, 5, 1), M=""M""],                                 
        [Month = #date(2025, 6, 1), M=""J""]
    },
    type table [Month = date, M = text]
)"
            ]
        }
    ]   
in
    //Make fnType the type for fn.
    Value.ReplaceType(fn, fnType)