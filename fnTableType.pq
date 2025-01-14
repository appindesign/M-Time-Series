(tbl as table, newColNames as list, newColTypes as list) as type =>
let
    tblColNames = Table.ColumnNames(tbl),
    tblColTypes = List.Transform(
        tblColNames, each [Type = Type.TableColumn(Value.Type(tbl), _), Optional = false]
    ),
    newColTypesRec = List.Transform(newColTypes, each [Type = _, Optional = false]),
    colNames = tblColNames & newColNames,
    colTypes = tblColTypes & newColTypesRec,
    result = type table Type.ForRecord(Record.FromList(colTypes, colNames), false)
in
    result