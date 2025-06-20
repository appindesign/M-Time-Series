let
    //Function definition
    fn = (lst as list, before as number, after as number, calculation as function) as list =>
        let
            data = List.Buffer(lst),
            metrics = List.Generate(
                () => [index = -1],
                each [index] < List.Count(data),
                each
                    [
                        index = [index] + 1,
                        window = List.Transform(
                            {List.Max({index - before, 0})..List.Min({index + after, List.Count(data) - 1})},
                            each data{_}
                        ),
                        metric = calculation(window)
                    ],
                each [metric]
            ),
            result = List.RemoveFirstN(metrics, 1)
        in
            result,
    //Function type definition
    fnType = type function (
        lst as (
            type list meta [
                Documentation.FieldCaption = "lst",
                Documentation.FieldDescription = "The list to be iterated over.",
                //Documentation.SampleValues = {10},
                //Documentation.AllowedValues = {},
                Documentation.IsMultiline = false,
                Documentation.IsCode = false
            ]
        ),
        before as (
            type number meta [
                Documentation.FieldCaption = "before",
                Documentation.FieldDescription = "The number of items before the current position to include.",
                //Documentation.SampleValues = {4},
                //Documentation.AllowedValues = {},
                Documentation.IsMultiline = false,
                Documentation.IsCode = false
            ]
        ),
        after as (
            type number meta [
                Documentation.FieldCaption = "after",
                Documentation.FieldDescription = "The number of items after the current position to include.",
                //Documentation.SampleValues = {4},
                //Documentation.AllowedValues = {},
                Documentation.IsMultiline = false,
                Documentation.IsCode = false
            ]
        ),
        calculation as (
            type function meta [
                Documentation.FieldCaption = "calculation",
                Documentation.FieldDescription = "The function to apply to the list of items in the window.",
                //Documentation.SampleValues = {4},
                //Documentation.AllowedValues = {},
                Documentation.IsMultiline = false,
                Documentation.IsCode = false
            ]
        )
    ) as list meta [
        Documentation.Name = "fnWindowCalculation",
        Documentation.LongDescription = "Solves the problem of calculating, fast, over a moving window.",
        Documentation.Examples = {
            [
                Description = "Calculate the centred moving average of the list {} over a window of +/- 3 items",
                Code = "fnMovingCalculation(
    {185.85, 191.5, 192.70, 193.65, 198.15, 196.85, 194.90, 194.5, 202.1, 204.9}, 
    3, 
    3, 
    List.Average
)",
                Result = " {190.925, 192.37, 193.1166667, 193.3714286, 194.6071429, 196.1214286, 197.8642857, 198.5666667, 198.65, 199.1}"
            ]
        }
    ]
in
    //Make fnType the type for fn.
    Value.ReplaceType(fn, fnType)
