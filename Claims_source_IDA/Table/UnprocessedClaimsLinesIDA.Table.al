table 55103 "Unprocessed Claims Lines IDA"
{
    Caption = 'Unprocessed Claims Lines';
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
            TableRelation = Item;

            trigger OnValidate()
            begin
                CalcFields("estimated UNIT Cost");
            end;
        }
        field(8; "Item Name"; TEXT[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
        }
        field(4; "Estimated Unit Cost"; Decimal)
        {
            Caption = 'estimated Cost';
            FieldClass = FlowField;

            CalcFormula = lookup(Item."Unit Cost" where("No." = field("Item No.")));
        }
        field(7; Quantity; Integer)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                rec."Estimated Total Cost" := rec.Quantity * rec."Estimated Unit Cost";
            end;
        }
        field(6; "Estimated Total Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
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

    trigger OnInsert()
    var
        unProcessedClaimsLines: Record "Unprocessed Claims Lines IDA";
    begin

        IF rec."Line No." = '' then begin
            if unProcessedClaimsLines.FindLast() then begin
                rec."Line No." := IncStr(unProcessedClaimsLines."Line No.");
            end
            ELSE
                rec."Line No." := 'LINE0001';
        end;
    end;
}
