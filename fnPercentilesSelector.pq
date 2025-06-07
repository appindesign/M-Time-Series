(lowestPercentile as number, highestPercentile as number, interPercentileRange as number) as table =>
    let
        //Test pararmeters
        /*
        lowestPercentile = 25,
        highestPercentile = 75,
        interPercentileRange = 25,
        */
        percentilesList = List.Numbers(
            lowestPercentile,
            1 + Number.RoundDown((highestPercentile - lowestPercentile) / interPercentileRange),
            interPercentileRange
        ),
        percentilesTable = Table.FromList(
            percentilesList, Splitter.SplitByNothing(), type table [Percentile = number], null, ExtraValues.Error
        ),
        #"Added k" = Table.AddColumn(percentilesTable, "k", each [Percentile] / 100, type number),
        /*
        #"Added Top/Bottom Percentile" = Table.AddColumn(
            #"Added Ordinal Description",
            "Top/Bottom Percentile",
            each
                {
                    "Top " & fnOrdinalSuffix(100 - [Percentile]) & " percentile",
                    "Median",
                    "Bottom " & fnOrdinalSuffix([Percentile]) & " percentile"
                }{1 + Number.Sign(50 - [Percentile])},
            type text
        ),
        */
        #"Added Bottom Percentile" = Table.AddColumn(
            #"Added k", "Bottom Percentile", each "Bottom " & fnOrdinalSuffix([Percentile]) & " percentile", type text
        ),
        #"Added Top Percentile" = Table.AddColumn(
            #"Added Bottom Percentile",
            "Top Percentile",
            each "Top " & fnOrdinalSuffix(100 - [Percentile]) & " percentile",
            type text
        )
    in
        #"Added Top Percentile"
