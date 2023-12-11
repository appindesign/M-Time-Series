( monthName as text ) as text =>
/*
A month name may be too long for a column or row heading.
The shortest replacement would be a single character.
However, some months share the same first character.
Therefore, add to the first character enough empty characters to distinguish each month.
I have used unicode character hex 200E.

The code creates a translation table.
It filters the table to the single row containing the month name.
From this row it selects the abbreviation of the month.
*/
let
    tt = #table(
        { "Name", "Abbreviation" },
        {
            {"January",     "J"},
            {"February",    "F"},
            {"March",       "M"},
            {"April",       "A"},
            {"May",         "M‎"},  //One empty character
            {"June",        "J‎"},  //One empty character
            {"July",        "J‎‎"},  //Two empty characters
            {"August",      "A‎"},  //One empty character
            {"September",   "S"},
            {"October",     "O"},
            {"November",    "N"},
            {"December",    "D"}
        }
    ),
    translationRecord = Table.SelectRows( tt, each ([Name] = monthName) ),
    M = translationRecord{0}[M]
in
    M