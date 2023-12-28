let
    fn = (x as number) as number => 0.5 * (Number.Exp(x) + Number.Exp(-x)),
    fnType = type function (
        x as (
            type number meta [
                Documentation.FieldCaption = "x",
                Documentation.LongDescription = "Enter the value for which you want sinh."
            ]
        )
    ) as number meta [
        Documentation.Name = "cosh",
        Documentation.LongDescription = "Calculate cosh(x)",
        Documentation.Examples = {
            [
                Description = "Find the cosh of pi",
                Code = "cosh(Number.PI)",
                Result = "11.591953275521519"
            ]
        }
    ]
in
    Value.ReplaceType(fn, fnType)
