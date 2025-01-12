let
    fn = (lst as list) as number => (List.Sum(lst) - 0.5 * (lst{0} + lst{List.Count(lst) - 1})) / (
        List.Count(lst) - 1
    ),
    //Function type definition
    fnType = type function (
        lst as (
            type list meta [
                Documentation.FieldCaption = "list",
                Documentation.FieldDescription = "Numerator",
                //Documentation.SampleValues = {10},
                //Documentation.AllowedValues = {},
                Documentation.IsMultiline = false,
                Documentation.IsCode = false
            ]
        )
    ) as number meta [
        Documentation.Name = "fnEvenCentredAverage",
        Documentation.LongDescription = "Solves the problem of calculating a centred average for an even number (n) of items.<p>Given an ordered list with an even number of items, there is no ""centre"" item. This presents a problem if you wish to calculate a centred average. A suitable solution starts by creating an odd list, of n+1 items, using the n/2 items before the item, the item itself and the n/2 items after the item. Passing such a list to this function will result in a centred average being calculated as 1/2*the first item plus 1/2*the last item plus the sum of the other items, all of this then being divided by n.",
        Documentation.Examples = {
            [
                Description = "Given CO2 levels for January 1959 to February 1960, calculate the twelve month centred average for July 2020.<p>",
                Code = "fnEvenAverage({315.58,316.49,316.65,317.72,318.29,318.15,316.54,314.8,313.84,313.33,314.81,315.58,316.43})",
                Result = "316.01708333333335"
            ]
        }
    ]
in
    //Make fnType the type for fn.
    Value.ReplaceType(fn, fnType)