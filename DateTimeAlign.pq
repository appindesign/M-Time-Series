let
    //Function definition
    fn = (timestamp as any, origin as any, interval as duration, roundingMode as text) as any =>
        let
            intervals = (timestamp - origin) / interval,
            roundingModes = [
                Up = origin + Number.RoundUp(intervals) * interval,
                Down = origin + Number.RoundDown(intervals) * interval,
                Nearest = origin + Number.Round(intervals, 0) * interval
            ]
        in
            Record.Field(roundingModes, roundingMode),
    //Function type definition
    fnType = type function (
        timestamp as (
            type any meta [
                Documentation.FieldCaption = "timestamp",
                Documentation.SampleValues = {#datetime(2020, 4, 1, 3, 47, 45)},
                Documentation.FieldDescription = "The timestamp to be rounded as time, date or datetime."
            ]
        ),
        origin as (
            type any meta [
                Documentation.FieldCaption = "origin",
                Documentation.SampleValues = {#datetime(2000, 1, 1, 0, 0, 0)},
                Documentation.FieldDescription = "The origin of the datetime dimension as time, date or datetime."
            ]
        ),
        interval as (
            type duration meta [
                Documentation.FieldCaption = "interval",
                Documentation.SampleValues = {#duration(0, 0, 15, 0)},
                Documentation.FieldDescription = "The interval between co-ordinates on the datetime dimension."
            ]
        ),
        rounding as (
            type text meta [
                Documentation.FieldCaption = "rounding mode",
                Documentation.SampleValues = {"Down"},
                Documentation.FieldDescription = "The direction in which the the timestamp is to be rounded.",
                Documentation.AllowedValues = {"Up", "Down", "Nearest"}
            ]
        )
    ) as number meta [
        Documentation.Name = "DateTimeAlign",
        Documentation.LongDescription = "This function rounds a timestamp to a co-ordinate on the datetime dimension.
            The use-case is real-world data collection where the sensor timestamp often ""jitters"" around the datetime dimensions's co-ordinates.
            The timestamp can be rounded down, up or to the nearest co-ordinate on the datetime dimension.",
        Documentation.Examples = {
            [
                Description = "Round #datetime(2020,4,1,3,47,26) down to the nearest 10 minutes",
                Code = "DateTimeAlign(#(cr)#(tab)#datetime(2020,4,1,3,47,26), #(cr)#(tab)#datetime(2020,1,1,0,0,0), #(cr)#(tab)#duration(0,0,10,0), #(cr)#(tab)""Down""#(cr))",
                Result = "#datetime(2020,4,1,3,40,0)"
            ]
        }
    ]
in
    //Make fnType the type for fn.
    Value.ReplaceType(fn, fnType)
