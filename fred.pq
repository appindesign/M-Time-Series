let
    a = 1,
    tt = #table(
        //tt=Translation Table
        {"Name", "Abbreviation"},
        {
            {"January", "J"},
            {"February", "F"},
            {"March", "M"},
            {"April", "A"},
            {"May", "M" & Text.Repeat(ec, 1)},
            //One empty character
            {"June", "J" & Text.Repeat(ec, 1)},
            //One empty character
            {"July", "J" & Text.Repeat(ec, 2)},
            //Two empty characters
            {"August", "A" & Text.Repeat(ec, 1)},
            //One empty character
            {"September", "S"},
            {"October", "O"},
            {"November", "N"},
            {"December", "D"}
        }
    ),
    b = 2
in
    a / b
