let
    //Function definition
    fn = (dimensionType as text, start as any, end as any, interval as duration) as any =>
        let
            tables = [
                times = fnTimes(start, fnCount(start, end, interval), interval),
                dates = fnDates(start, fnCount(start, end, interval), interval),
                datetimes = fnDatetimes(start, fnCount(start, end, interval), interval)
            ],
            fnCount = (start as any, end as any, interval as duration) as number =>
                if (Value.Type(end) = Number.Type) then
                    end
                else
                    1 + Number.RoundDown((end - start) / interval),
            fnTimes = (start as time, count as number, interval as duration) as table =>
                Table.FromList(
                    List.Times(start, count, interval),
                    Splitter.SplitByNothing(),
                    type table [Time = time],
                    null,
                    ExtraValues.Error
                ),
            fnDates = (start as date, count as number, interval as duration) as table =>
                Table.FromList(
                    List.Dates(start, count, interval),
                    Splitter.SplitByNothing(),
                    type table [Date = date],
                    null,
                    ExtraValues.Error
                ),
            fnDatetimes = (start as datetime, count as number, interval as duration) as table =>
                Table.FromList(
                    List.DateTimes(start, count, interval),
                    Splitter.SplitByNothing(),
                    type table [Datetime = datetime],
                    null,
                    ExtraValues.Error
                )
        in
            Record.Field(tables, dimensionType),
    //Function type definition
    fnType = type function (
        dimensionType as (
            type text meta [
                Documentation.FieldCaption = "dimension type",
                Documentation.SampleValues = {"datetime"},
                Documentation.FieldDescription = "The type of the dimension.",
                Documentation.AllowedValues = {"times", "dates", "datetimes"}
            ]
        ),
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
        Documentation.Name = "TimeDimension",
        Documentation.LongDescription = "Create a time series dimension",
        Documentation.Examples = {
            [
                Description = "Create a datetime dimension starting at 6:15am on 1st Jan 2000, ending at 6:45am on 1st Jan 2000, with co-ordinate intervals of 15 minutes.",
                Code = "fn(#(cr)   ""datetimes"", #(cr)   #datetime(2000,1,1,6,15,0), #(cr)   #datetime(2000,1,1,6,45,0), #(cr)   #duration(0,0,15,0) #(cr)) ",
                Result = "Datetime #(cr)1/1/2000 06:15 #(cr)1/1/2000 06:30 #(cr)1/1/2000 06:45"
            ]
        }
    ]
in
    //Make fnType the type for fn.
    Value.ReplaceType(fn, fnType)