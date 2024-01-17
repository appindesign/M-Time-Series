let
    fn = (monthName as text) as text =>
        let
            ec = Character.FromNumber(8206),
            //ec=Empty character
            tt = #table(
                //tt=Translation Table
                {"Name", "Abbreviation"},
                {
                    {"January", "J"},
                    {"February", "F"},
                    {"March", "M"},
                    {"April", "A"},
                    {"May", "M" & Text.Repeat(ec, 1)},
                    {"June", "J" & Text.Repeat(ec, 1)},
                    {"July", "J" & Text.Repeat(ec, 2)},
                    {"August", "A" & Text.Repeat(ec, 1)},
                    {"September", "S"},
                    {"October", "O"},
                    {"November", "N"},
                    {"December", "D"}
                }
            ),
            M = tt{List.PositionOf(tt[Name],monthName)}[Abbreviation]
        in
            M,
    //Function type definition
    fnType = type function (
        monthName as (
            type text meta [
                Documentation.FieldCaption = "monthName",
                Documentation.SampleValues = {"August"},
                Documentation.AllowedValues = {
                    "January",
                    "February",
                    "March",
                    "April",
                    "May",
                    "June",
                    "July",
                    "August",
                    "September",
                    "October",
                    "November",
                    "December"
                },
                Documenation.FieldDescription = "Name of month"
            ]
        )
    ) as text meta [
        Documentation.Name = "MonthNameAsM",
        Documentation.LongDescription = "A month name may be too long for a column or row heading.
          The shortest replacement would be a single character.
          However, some months share the same first character.
          Therefore, add to the first character enough empty characters to distinguish each month.
          I have used unicode character hex 200E, decimal 8206.

          The function creates a translation table.
          It finds the row in the table containing the month name.
          From this row it selects the abbreviation of the month.",
        Documentation.Examples = {
            [
                Description = "Abbreviate April",
                Code = "MonthNameAsM( ""August"" ) ",
                Result = "A"
            ],
            [
                Description = "Abbreviate August",
                Code = "MonthNameAsM( ""August"" ) ",
                Result = "A (followed by an empty character)"
            ],
            [
                Description = "Abbreviate the entries in column ""Month Name""",
                Code = "= Table.TransformColumns( #""Previous Step"", {{""Month Name"", each MonthNameAsM(_)}} )",
                Result = "Month Name populated with abbreviated month  names."
            ],
            [
                Description = "Add a column, M, abbreviating the entries in column ""Month Name""",
                Code = "= Table.AddColumn( #""Previous Step"", ""M"", each MonthNameAsM(_[Month Name]), type text )",
                Result = "A new column, M, with abbreviated month names."
            ]                      
        }
    ]
in
    //Replace the default type with the custom function type.
    Value.ReplaceType(fn, fnType)
