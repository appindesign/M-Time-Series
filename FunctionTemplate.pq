let

    //Function definition
    fn = ( a as number, b as number ) as number => a / b,

    //Function type definition
    fnType = type function (
        a as (
            type number meta [
            Documentation.FieldCaption = "a",
            Documentation.SampleValues = { 10 },
            Documenation.FieldDescription = "Numerator"
        ]),
        b as (type number meta [
            Documentation.FieldCaption = "b",
            Documentation.SampleValues = { 4 },
            Documentation.FieldDescription = "Denominator"
        ])
    )
        as number meta [
            Documentation.Name = "Divide",
            Documentation.LongDescription = "Divide a by b",
            Documentation.Examples = {
                [
                    Description =  "Divide 10 by 4",
                    Code = "Divide( 10, 4 ) ",
                    Result = "2.5"
                ]
            }
        ]

in
    //Replace the default type with the custom type.
    Value.ReplaceType( fn, fnType )
