let
    fn = (tbl as table, lists as list, names as list, types as list) as table =>
        let
            lists = Table.ToColumns(tbl) & lists,
            tblTypes = fnTableType(tbl, names, types),
            combined = Table.FromColumns(lists, tblTypes)
        in
            combined,
    //Function type definition
    fnType = type function (
        tbl as (
            type table meta [
                Documentation.FieldCaption = "table",
                Documentation.FieldDescription = "The table to which lists will be added.",
                //Documentation.SampleValues = {10},
                //Documentation.AllowedValues = {},
                Documentation.IsMultiline = false,
                Documentation.IsCode = false
            ]
        ),
        lists as (
            type list meta [
                Documentation.FieldCaption = "lists",
                Documentation.FieldDescription = "The lists to be added to the table.",
                //Documentation.SampleValues = {4},
                //Documentation.AllowedValues = {},
                Documentation.IsMultiline = false,
                Documentation.IsCode = false
            ]
        ),        
        names as (
            type list meta [
                Documentation.FieldCaption = "names",
                Documentation.FieldDescription = "The names of the columns to be added to the table.",
                //Documentation.SampleValues = {4},
                //Documentation.AllowedValues = {},
                Documentation.IsMultiline = false,
                Documentation.IsCode = false
            ]
        ),
        types as (
            type list meta [
                Documentation.FieldCaption = "types",
                Documentation.FieldDescription = "The types of the columns to be added to the table.",
                //Documentation.SampleValues = {4},
                //Documentation.AllowedValues = {},
                Documentation.IsMultiline = false,
                Documentation.IsCode = false
            ]
        )       
    ) as table meta [
        Documentation.Name = "fnTableAddLists",
        Documentation.LongDescription = "Add columns named ""Cloud cover"" and ""Precipitation"" to the table using a list of cloud cover descriptions and a list of precipitation figures.",
        Documentation.Examples = {[
            Description = "",
            Code = 
"fnTableAddLists(
    Table.FromRecords({
        [Day = ""Monday"", Temperature = 4],
        [Day = ""Tuesday"", Temperature = 5],
        [Day = ""Wednesday"", Temperature = 6]
    }),
    {{""Sunny"",""Dull"",""Cloudy""},{0, 1, 1.5}},
    {""Cloud cover"", ""Precipitation""},
    { Text.Type, Number.Type }
)",
            Result = 
"Table.FromRecords({
    [Day = ""Monday"", Temperature = 4, Cloud cover = ""Sunny"", Precipitation = 0],
    [Day = ""Tuesday"", Temperature = 5, Cloud cover = ""Dull"", Precipitation = 1],
    [Day = ""Wednesday"", Temperature = 6, Cloud cover = ""Cloudy"", Precipitation = 1.5]
})"
        ]}
    ]
in
    //Make fnType the type for fn.
    Value.ReplaceType(fn, fnType)