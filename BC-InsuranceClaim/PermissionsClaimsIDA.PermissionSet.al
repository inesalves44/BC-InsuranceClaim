permissionset 50100 "Permissions Claims"
{
    Assignable = true;
    Caption = 'Permissions Claims', MaxLength = 30;
    Permissions =
        table "attachments IDA" = X,
        tabledata "attachments IDA" = RMID,
        table "Claims Ledger Entries IDA" = X,
        tabledata "Claims Ledger Entries IDA" = RMID,
        table "Processed Claims Header IDA" = X,
        tabledata "Processed Claims Header IDA" = RMID,
        table "Documents Claims IDA" = X,
        tabledata "Documents Claims IDA" = RMID,
        table "Processed Claims Lines IDA" = X,
        tabledata "Processed Claims Lines IDA" = RMID,
        table "Unprocessed Claims Lines IDA" = X,
        tabledata "Unprocessed Claims Lines IDA" = RMID,
        table "Unprocessed Claims Header IDA" = X,
        tabledata "Unprocessed Claims Header IDA" = RMID,
        table "Vehicles IDA" = X,
        tabledata "Vehicles IDA" = RMID,
        codeunit "Create a Number Series IDA" = X,
        codeunit "Export and Import Files IDA" = X,
        codeunit "Posting Claims IDA" = X,
        page "Attatchments FactBox IDA" = X,
        page "Navigate IDA" = X,
        page "Vehicles List IDA" = X,
        page "Vendors Claims Ledger Entries" = X,
        page "Processed Claims Card Lines" = X,
        page "Atta. FactBox Processed IDA" = X,
        page "Vehicles card IDA" = X,
        page "Unprocessed Claims IDA" = X,
        page "Processed Claims List IDA" = X,
        page "Unprocessed Claim IDA" = X,
        page "Processed Claim Card IDA" = X,
        page "attachments card IDA" = X,
        page "Cust. Claims Led. Entries IDA" = X,
        page "Unprocessed Claims List IDA" = X;
}
