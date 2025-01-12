let
    //Function definition
    fn = (lst as list, seasons as number) as list =>
        let
            bufferedLst = List.Buffer(lst),
            averages = List.Buffer(List.Transform({1..seasons}, each List.Average(List.Alternate(bufferedLst, seasons - 1, 1, _ - 1)))),
            sa = List.Transform({0..List.Count(bufferedLst) - 1}, each averages{Number.Mod(_, seasons)})
        in
            sa,
    //Function type definition
    fnType = type function (
        lst as (
            type list meta [
                Documentation.FieldCaption = "list",
                Documentation.FieldDescription = "The time series values",
                //Documentation.SampleValues = {10},
                //Documentation.AllowedValues = {},
                Documentation.IsMultiline = false,
                Documentation.IsCode = false
            ]
        ),
        seasons as (
            type number meta [
                Documentation.FieldCaption = "seasons",
                Documentation.FieldDescription = "The number of seasons",
                //Documentation.SampleValues = {4},
                //Documentation.AllowedValues = {},
                Documentation.IsMultiline = false,
                Documentation.IsCode = false
            ]
        )
    ) as list meta [
        Documentation.Name = "fnSeasonalAverage",
        Documentation.LongDescription = "Solves the problem of calculating the average for each season in a time series.",
        Documentation.Examples = {[
            Description = "Given ten years of monthly average temperature, calculate the seasonal pattern."
            //Code = "Divide( 10, 4 ) ",
            //Result = "2.5"
        ]}
    ]
in
    //Make fnType the type for fn.
    Value.ReplaceType(fn, fnType)