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
            Caption = 'Customer NO.';
        }
        field(9; "Customer Name"; text[100])
        {
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
        field(6; "responsible Payment"; Boolean)
        {
            Caption = 'responsible Payment';
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
}


