(tbl as table, col as text) as table =>
    let
        #"Duplicated Column" = Table.DuplicateColumn(tbl, col, "Fill Down"),
        #"Duplicated Column1" = Table.DuplicateColumn(#"Duplicated Column", col, "Fill Up"),
        #"Duplicated Column2" = Table.DuplicateColumn(#"Duplicated Column1", col, "xxx"),
        #"Filled Down" = Table.FillDown(#"Duplicated Column2", {"Fill Down"}),
        #"Filled Up" = Table.FillUp(#"Filled Down", {"Fill Up"}),
        #"Added Custom1" = Table.AddColumn(
            #"Filled Up", "Interpolation", each if [xxx] <> null then [xxx] else 0.5 * ([Fill Down] + [Fill Up]),
            type number
        ),
        Custom1 = Table.AddColumn(
            #"Added Custom1",
            "Interpolated Value",
            each if [xxx] <> null then null else 0.5 * ([Fill Down] + [Fill Up]),
            type number
        ),
        #"Removed Columns1" = Table.RemoveColumns(Custom1, {col, "xxx", "Fill Down", "Fill Up"}),
        result = Table.RenameColumns(#"Removed Columns1", {{"Interpolation", col}})
    in
        result
