( monthName as text ) as text =>
/*
A month name may be too long for a column or row heading.
The shortest replacement would be a single character.
However, some months share the same first character.
Therefore, add to the first character enough empty characters to distinguish each month.
I have used unicode character hex 200E, decimal 8206.

The code creates a translation table.
It filters the table to the single row containing the month name.
From this row it selects the abbreviation of the month.
*/
let
    ec = Character.FromNumber(8206),    //Empty character
    tt = #table(
        { "Name", "Abbreviation" },
        {
            {"January",     "J"},
            {"February",    "F"},
            {"March",       "M"},
            {"April",       "A"},
            {"May",         "M‎" & Text.Repeat(ec, 1)},  //One empty character
            {"June",        "J‎" & Text.Repeat(ec, 1)},  //One empty character
            {"July",        "J‎‎" & Text.Repeat(ec, 2)},  //Two empty characters
            {"August",      "A‎" & Text.Repeat(ec, 1)},  //One empty character
            {"September",   "S"},
            {"October",     "O"},
            {"November",    "N"},
            {"December",    "D"}
        }
    ),
    translationRecord = Table.SelectRows( tt, each ([Name] = monthName) ),
    M = translationRecord{0}[Abbreviation]
in
    M
