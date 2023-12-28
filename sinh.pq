let
    fn = (x as number) as number => 0.5 * (Number.Exp(x) - Number.Exp(-x)),
    fnType = type function (
        x as (
            type number meta [
                Documentation.FieldCaption = "x",
                Documentation.LongDescription = "Enter the value for which you want sinh."
            ]
        )
    ) as number meta [
        Documentation.Name = "sinh",
        Documentation.LongDescription = "Calculate sinh(x)",
        Documentation.Examples = {
            [
                Description = "Find the sinh of pi",
                Code = "sinh(Number.PI)",
                Result = "11.548739357257748"
            ]
        }
    ]
in
    Value.ReplaceType(fn, fnType)
