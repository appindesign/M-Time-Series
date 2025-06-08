let
    //Function definition
    fn = (tbl as table, additionalNames as list, additionalTypes as list) as type =>
        let
            //Get tbl's table type.
            tblType = Value.Type(tbl),
            //Get a list of tbl's column names and tbl's type records.
            //Give Type.TableColumn a table type and a column name and it returns the type of the column.
            tblNames = Table.ColumnNames(tbl),
            tblTypeRecords = List.Transform(tblNames, each [Type = Type.TableColumn(tblType, _), Optional = false]),
            //Get a list of the type records of the additional types.
            additionalTypeRecords = List.Transform(additionalTypes, each [Type = _, Optional = false]),
            //Append the lists of tbl's names and type records with the additional names and type records.
            names = tblNames & additionalNames,
            types = tblTypeRecords & additionalTypeRecords,
            //Construct the type of the new table.
            //Record.FromList takes two lists and forms a record.
            //The field names are taken from the second parameter.
            //The field values are taken from the first parameter.
            //Type.ForRecord turns the type into a record.
            result = type table Type.ForRecord(Record.FromList(types, names), false)
        in
            result,
    //Function type definition
    fnType = type function (
        tbl as (
            type table meta [
                Documentation.FieldCaption = "table",
                Documentation.FieldDescription = "Numerator",
                //Documentation.SampleValues = {10},
                //Documentation.AllowedValues = {},
                Documentation.IsMultiline = false,
                Documentation.IsCode = false
            ]
        ),
        additionalNames as (
            type list meta [
                Documentation.FieldCaption = "Additional Names",
                Documentation.FieldDescription = "Denominator",
                //Documentation.SampleValues = {4},
                //Documentation.AllowedValues = {},
                Documentation.IsMultiline = false,
                Documentation.IsCode = false
            ]
        ),
        additionalTypes as (
            type list meta [
                Documentation.FieldCaption = "Additional Types",
                Documentation.FieldDescription = "Denominator",
                //Documentation.SampleValues = {4},
                //Documentation.AllowedValues = {},
                Documentation.IsMultiline = false,
                Documentation.IsCode = false
            ]
        )
    ) as type meta [
        Documentation.Name = "fnTableType",
        Documentation.LongDescription = "Solves the problems of getting a table's type or getting a table's type if it were extended with additional columns.",
        Documentation.Examples = {
            [
                Description = "Get the type of a table.",
                Code = "fnTableType(
    Table.FromRecords({
        [Day = ""Monday"", Temperature = 4],
        [Day = ""Tuesday"", Temperature = 5],
        [Day = ""Wednesday"", Temperature = 6]
        },
        type table [Day=Text.Type, Temperature=Int64.Type])
    ),
    {},
    {}
)",
                Result = "The type of the table."
            ],
            [
                Description = "Get the type of a table with additional columns called ""Cloud Cover"" and ""Precipitation"", of types text and number.",
                Code = "fnTableType(
    Table.FromRecords({
        [Day = ""Monday"", Temperature = 4],
        [Day = ""Tuesday"", Temperature = 5],
        [Day = ""Wednesday"", Temperature = 6]
        },
        type table [Day=Text.Type, Temperature=Int64.Type]
    ),
    {""Cloud Cover"", ""Precipitation""},
    {Text.Type, Number.Type}
)",
                Result = "The type of the table with the additional columns."
            ]
        }
    ]
in
    //Make fnType the type for fn.
    Value.ReplaceType(fn, fnType)
