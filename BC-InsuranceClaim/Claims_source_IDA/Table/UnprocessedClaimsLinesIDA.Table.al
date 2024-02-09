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
            var
                items: Record Item;
            begin
                if items.Get(rec."Item No.") then begin
                    rec."Item Name" := items.Description;
                    rec."Estimated Unit Cost" := items."Unit Cost";
                end;
            end;
        }
        field(8; "Item Name"; TEXT[100])
        {
            Caption = 'Item Name';
        }
        field(4; "Estimated Unit Cost"; Decimal)
        {
            Caption = 'Estimated Cost';
        }
        field(7; Quantity; Integer)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                rec."Estimated Total Cost" := rec.Quantity * rec."Estimated Unit Cost";

                if claimHeader.get(rec."Document No.") then begin
                    claimHeader."Estimated Payment" += rec."Estimated Total Cost" - xrec."Estimated Total Cost";
                    claimHeader.Modify();
                end;
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

    var
        claimHeader: Record "unProcessed Claims Header IDA";

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

    trigger OnDelete()
    begin
        if claimHeader.get(rec."Document No.") then begin
            claimHeader."Estimated Payment" -= rec."Estimated Total Cost";
            claimHeader.Modify();
        end;
    end;

}
