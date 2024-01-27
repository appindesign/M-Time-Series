let
    //Function definition
    fn = (area as text, location as text, optional region as text) as datetime =>
        let
            reg = if region <> null then region else "",
            dt = DateTimeZone.RemoveZone(
                DateTimeZone.From(
                    Json.Document(
                        Web.Contents("https://worldtimeapi.org/api/timezone/" & area & "/" & location & "/" & reg)
                    )[datetime]
                )
            )
        in
            dt,
    //Function type definition
    fnType = type function (
        area as (
            type text meta [
                Documentation.FieldCaption = "area",
                Documentation.FieldDescription = "www.worldtimeapi.org area",
                Documentation.SampleValues = {"europe"},
                //Documentation.AllowedValues = {},
                Documentation.IsMultiline = false,
                Documentation.IsCode = false
            ]
        ),
        location as (
            type text meta [
                Documentation.FieldCaption = "location",
                Documentation.FieldDescription = "www.worldtimeapi.org location",
                Documentation.SampleValues = {"london"},
                //Documentation.AllowedValues = {},
                Documentation.IsMultiline = false,
                Documentation.IsCode = false
            ]
        ),
        optional region as (
            type text meta [
                Documentation.FieldCaption = "region",
                Documentation.FieldDescription = "www.worldtimeapi.org region",
                Documentation.SampleValues = {" "},
                //Documentation.AllowedValues = {},
                Documentation.IsMultiline = false,
                Documentation.IsCode = false
            ]
        )
    ) as datetime meta [
        Documentation.Name = "DateTimeSafeLocalNow",
        Documentation.LongDescription = "
    Purpose<br>
        Consider you have a table of time-series data, collected in your timezone.
        You want to calculate the age of each reading and so you try a calculation,
            Age = DateTime.LocalNow() - Readings[Datetime]
        All works well. Then you publish to the Power BI Service, in a different timezone.
        For the Service, DateTime.LocalNow() is different from your desktop.
        Your calculation gives the wrong age.
        <p>
        The purpose of this function is to give a Local Now which is always in the same time zone.
        <p>
    Method<br>
        The function reaches out to a 3rd party api.
        Your ask the api for the time in a timezone of your choice.
        This would normally be the timezone of your readings.
        <p>
        The timezone is specified by area, location and region parameters.
        Allowed values are documented at https://worldtimeapi.org/.
        Entering https://worldtimeapi.org/api/timezone shows the allowed values.
        Use a space for region if it is not needed.
        <p>
        The function calls the api and a record is returned.
        The record contains a field ""datetime"". 
        Despite its name, it contains zone data.
        This is converted to type datetimezone.
        Then the zone is removed.
            It would not work to convert type to datetime from datetimezone.
            This is because the conversion converts to UTC.
            You must remove the zone instead.
        ",
        Documentation.Examples = {
            [
                Description = "Find the local datetime in New York",
                Code = "LocalDateTime( ""America"", ""New_York"" )",
                Result = "Returns the local datetime in New York"
            ],
            [
                Description = "Find the local datetime in London",
                Code = "LocalDateTime( ""America"", ""Argentina"", ""Buenos_Aires"" )",
                Result = "Returns the local datetime in Buenos Aires"
            ]
        }
    ]
in
    //Make fnType the type for fn.
    Value.ReplaceType(fn, fnType)
