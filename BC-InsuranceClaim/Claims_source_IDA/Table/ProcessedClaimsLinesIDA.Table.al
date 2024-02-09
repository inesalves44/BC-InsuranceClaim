table 55117 "Processed Claims Lines IDA"
{
    Caption = 'Processed Claims Lines';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Unprocessed Claims Header IDA";
        }
        field(2; "Line No."; Code[20])
        {
            Caption = 'Line No.';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(8; "Item Name"; TEXT[100])
        {
        }
        field(4; "Estimated Unit Cost"; Decimal)
        {
            Caption = 'estimated Cost';
        }
        field(7; Quantity; Integer)
        {
            DataClassification = CustomerContent;

        }
        field(6; "Estimated Total Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(5; Damage; text[2048])
        {
            Caption = 'Damage';
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }


}
