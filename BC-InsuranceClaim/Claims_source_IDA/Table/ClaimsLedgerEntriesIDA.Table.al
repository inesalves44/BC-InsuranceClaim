table 55108 "Claims Ledger Entries IDA"
{
    Caption = 'Claims Ledger Entries';
    DataClassification = CustomerContent;

    fields
    {
        field(7; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(1; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
        }
        field(8; "Vendor Name"; text[100])
        {
        }
        field(2; "Customer NO."; Code[20])
        {
            Caption = 'Customer No.';
        }
        field(9; "Customer Name"; text[100])
        {
            Caption = 'Customer Name';
        }
        field(3; "Date Claim"; Date)
        {
            Caption = 'Date Claim';
        }
        field(4; "Total Cost"; Decimal)
        {
            Caption = 'Total Cost';
        }
        field(5; Responsible; Enum "Responsible IDA")
        {
            Caption = 'Responsible';
        }

    }
    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
        key(SK; "date claim")
        { }
    }

    procedure OpenDocument()
    var
        processedClaims: Record "Processed Claims Header IDA";
    begin
        if processedClaims.get(rec."Document No.") then
            page.Run(page::"Processed Claim Card IDA", processedClaims);
    end;
}


