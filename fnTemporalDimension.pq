let
    //Function definition
    fn = (start as any, end as any, interval as duration) as any =>
        let
            startType = Value.Type(start),
            endType = Value.Type(end),
            //Acknowledgement for the idea of next line to fnType2Text at https://stackoverflow.com/questions/73946747/powerquery-how-to-convert-cast-type-type-to-type-text
            columnTitle = Text.Proper(Table.Schema(#table(type table [col = startType], {}))[Kind]{0}),
            count = if (endType = Number.Type) then end else 1 + Number.RoundDown((end - start) / interval),
            lst = List.DateTimeZones(DateTimeZone.From(start), count, interval),
            tbl = Table.FromList(lst, Splitter.SplitByNothing(), type table [Timestamp = startType]),
            typedTbl = Table.TransformColumnTypes(tbl, {{"Timestamp", startType}}),
            titledTbl = Table.RenameColumns(typedTbl, {{"Timestamp", columnTitle}})
        in
            titledTbl,
    //Function type definition in p
    fnType = type function (
        start as (
            type any meta [
                Documentation.FieldCaption = "start",
                Documentation.SampleValues = {"1/1/2000 00:06:15"},
                Documentation.FieldDescription = "The first co-ordinate in the dimension."
            ]
        ),
        end as (
            type any meta [
                Documentation.FieldCaption = "end",
                Documentation.SampleValues = {"1/1/2000 00:06:45", "30"},
                Documentation.FieldDescription = "The last co-ordinate in the dimension or the number of co-ordinates"
            ]
        ),
        interval as (
            type duration meta [
                Documentation.FieldCaption = "interval",
                Documentation.SampleValues = {"0.00:01:30"},
                Documentation.FieldDescription = "The interval between co-ordinates."
            ]
        )
    ) as table meta [
        Documentation.Name = "fnTimeline",
        Documentation.LongDescription = "Create a temporal dimension. The dimension will inherit the type of the ""start"" parameter. ""Start"" must be of type <code>time, date or datetime</code>.",
        Documentation.Examples = {
            [
                Description = "Create a datetime dimension starting at 6:15am on 1st Jan 2000, ending at 6:45am on 1st Jan 2000, with co-ordinate intervals of 15 minutes.",
                Code = "fnTimeline(#(cr) #datetime(2000,1,1,6,15,0), #(cr) #datetime(2000,1,1,6,45,0), #(cr) #duration(0,0,15,0) #(cr))",
                Result = "Datetime #(cr)1/1/2000 06:15 #(cr)1/1/2000 06:30 #(cr)1/1/2000 06:45"
            ]
        }
    ]
in
    //Make fnType the type for fn.
    Value.ReplaceType(fn, fnType)
