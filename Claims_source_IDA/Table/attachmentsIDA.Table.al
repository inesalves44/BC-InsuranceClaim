table 55104 "attachments IDA"
{
    Caption = 'attachments';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Claim Document No."; Code[20])
        {
            Caption = 'Claim Document No.';
            TableRelation = "Unprocessed Claims Header IDA";
        }
        field(3; "Document Description"; Text[2048])
        {
            Caption = 'Document Description';
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(5; Documents; MediaSet)
        {
            Caption = 'Documents';
        }
    }
    keys
    {
        key(PK; "Entry No.", "Claim Document No.")
        {
            Clustered = true;
        }
    }

}
