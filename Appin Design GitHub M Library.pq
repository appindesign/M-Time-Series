// Appin Design GitHub Library
let
    helperFunction = 
        let
            //Function definition
            fn = () =>
                let
                    repo = "https://api.github.com/repos/appindesign/M-Time-Series",
                    mainBranch = "main",
                    extensions = {".pq"},
                    functionNameField = "Documentation.Name",
                    createFunctions = true, //set to false for troubleshooting
                    
                    GetRepoInfo = Table.SelectRows(
                        Table.ExpandRecordColumn(
                            Table.FromList(
                                Json.Document(
                                    Web.Contents(repo, [
                                        RelativePath = "git/trees/" & mainBranch,
                                        Query = [recursive = "1"]
                                    ])
                                )[tree],
                                Splitter.SplitByNothing(),
                                null,
                                null,
                                ExtraValues.Error
                            ),
                            "Column1",
                            {"path", "url", "sha"}
                        ),
                        each List.AnyTrue(List.Transform(extensions, (ext) => Text.EndsWith([path], ext)))
                    ),

                    GetRepoContent = Table.AddColumn(
                        Table.AddColumn(
                            GetRepoInfo,
                            "Content",
                            each
                                let
                                    sha = [sha]
                                in
                                    Text.FromBinary(
                                        Binary.FromText(
                                            Json.Document(Web.Contents(repo, [RelativePath = "git/blobs/" & sha]))[content],
                                            BinaryEncoding.Base64
                                        )
                                    )
                        ),
                        "FunctionName",
                        each
                            if
                                Text.Contains([Content], functionNameField & " =") = false
                                and Text.Contains([Content], functionNameField & "=") = false
                            then
                                Text.Replace([path], "/", ".")
                            else
                                Text.BetweenDelimiters(Text.BetweenDelimiters([Content], functionNameField, ","), """", """")
                    ),

                    AddFunctionRecord =
                        let
                            //#"Extracted Text Before Delimiter" = Table.TransformColumns(GetRepoInfo, {{"path", each Text.BeforeDelimiter(_, "."), type text}}),
                            //additionalFunctions = Record.FromList( #"Extracted Text Before Delimiter"[path], #"Extracted Text Before Delimiter"[path] ),
                            additionalFunctions = [fnTableType = "fnTableType"],
                            functionList = Record.Combine({#shared, additionalFunctions})
                        in
                            Table.AddColumn(
                                Table.AddColumn(
                                    Table.AddColumn(
                                        GetRepoContent,
                                        "Substrings",
                                        each
                                            let
                                                Content = [Content],
                                                FoundFunctions = List.Select(
                                                    Record.FieldNames(functionList), each Text.Contains(Content, _)
                                                )
                                            in
                                                FoundFunctions
                                    ),
                                    "FunctionRecord",
                                    each
                                        try
                                            Record.FromList(
                                                List.Transform(
                                                    [Substrings], (item) => Expression.Evaluate(item, functionList)
                                                ),
                                                [Substrings]
                                            ) otherwise null
                                ),
                                "Functions",
                                each Record.AddField([], [FunctionName], Expression.Evaluate([Content], functionList))
                            ),
                            
                    CreateEndResult =
                        if createFunctions = true then
                            Record.Combine(AddFunctionRecord[Functions])
                        else
                            Table.RemoveColumns(AddFunctionRecord, {"url", "sha", "Substrings", "FunctionRecord"})
                in
                    CreateEndResult,
            //Function type definition
            fnType = type function () as number meta [
                Documentation.Name = "Retrieve functions from Gitub",
                Documentation.FunctionName = "Github.RetrieveFiles",
                Documentation.Description = "This function retrieves the files from a specified github repo and either shows the data or converts them to functions.",
                Documentation.Examples = {
                    [
                        Description = "Retieve github data",
                        Code = "FunctionName()",
                        Result = "Retrieved github data. Note that options, etc are all set in the top of the function. (repo, mainBranch, extensions, functionNameField and createFunctions)"
                    ]
                }
            ]
        in
            //Make fnType the type for fn.
            Value.ReplaceType(fn, fnType)
in
    helperFunction()