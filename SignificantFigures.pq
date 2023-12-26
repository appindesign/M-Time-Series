let
    //Function definition
    fn = (x as number, significantFigures as number, optional roundingMode as number) as number =>
        /*
        A number, x, may be expressed in normalised scientific notation as,
            x = m * 10^n          (1)
        where 1 <= m < 10 and n is an integer.

        Taking logs of both sides of (1), gives
            log(x) = log(m) + n   (2)
        
        There are points to be aware of:
        - The log of 0 is undefined.
        - You cannot take the log of a negative number.
        For x = 0 you return 0.
        Otherwise, take the log of the absolute value of x.
        (When calculating m, the sign of x will be re-established.)

        Since 1 <= m < 10, log(m) must satisfy
            0 <= log(m) < 1       (3)

        Therefore the decimal part of log(x) is log(m) an n is the integer part.
        Rounding log(x) down to zero decimal places will yield n.
        This will allow you to calculate m.

        Dividing m by 10 will yield a number satisfying
            0.1 <= number < 1     (4)
        with its most significant digit being the first after the decimal point.

        Now Number.Round may be used on this number to reduce the significant figures.
        The optional "mode" parameter is one of the RoundingMode.Type values.
        See - https://learn.microsoft.com/en-us/powerquery-m/roundingmode-type.

        Finally you can re-create x, rounded to the significant figures.
        */
        let
            //Calculate n
            logAbsx = Number.Log(Number.Abs(x), 10),
            n = Number.RoundDown(logAbsx),
            //Calculate m
            zeroes = Number.Power(10, n),
            m = x / zeroes,
            //Determine the rounding mode.
            rMode = if roundingMode <> null then roundingMode else RoundingMode.ToEven,
            //Calculate x to sigFigs
            xToSigFigs = 10 * Number.Round(m / 10, significantFigures, rMode) * zeroes
        in
            //Allow for the special case of x = 0.
            if (x = 0) then
                0
            else
                xToSigFigs,
    //Function type definition
    fnType = type function (
        x as (
            type number meta [
                Documentation.FieldCaption = "x",
                Documentation.SampleValues = {3.1415},
                Documenation.FieldDescription = "The number to be rounded."
            ]
        ),
        signficantFigures as (
            type number meta [
                Documentation.FieldCaption = "Significant figures to round to",
                Documentation.SampleValues = {4},
                Documentation.FieldDescription = "The number of significant figures to round to."
            ]
        ),
        optional roundingMode as (
            type number meta [
                Documentation.FieldCaption = "Rounding mode",
                Documentation.SampleValues = {4},
                Documentation.FieldDescription = "The rounding mode."
            ]
        )
    ) as number meta [
        Documentation.Name = "SignificantFigures",
        Documentation.LongDescription = "Round a number to a number of significant figures. ""roundingMode"" is optional with default of RoundingMode.ToEven. For the allowed values of rounding mode refer to Power Query Learn, under ""RoundingMode.Type"".",
        Documentation.Examples = {
            [
                Description = "Find 3.1415926 to 4 signficant figures, rounding to even.",
                Code = "SignificantFigures( 3.1415, 4 ) ",
                Result = "3.142"
            ],
            [
                Description = "Find 0.031415926 to 4 signficant figures, rounding down.",
                Code = "SignificantFigures( 0.031415, 4, RoundingMode.Down ) ",
                Result = "0.03141"
            ]
        }
    ]
in
    //Replace the default type with the custom type.
    Value.ReplaceType(fn, fnType)
