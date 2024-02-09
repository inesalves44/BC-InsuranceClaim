/// <summary>
/// Table Unprocessed Claims Header IDA (ID 55102).
/// </summary>
table 55102 "Unprocessed Claims Header IDA"
{
    Caption = 'Unprocessed Claims Header';
    DataClassification = CustomerContent;


    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;

        }
        field(2; "Insured(Customer) No."; Code[20])
        {
            Caption = 'Insured(Customer) No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
            NotBlank = true;

            trigger OnValidate()
            begin
                CalcFields("Customer name");
            end;
        }
        field(11; "Customer name"; text[100])
        {
            Caption = 'Insured(Customer) Name';
            FieldClass = FlowField;

            CalcFormula = lookup(Customer.Name where("No." = field("Insured(Customer) No.")));
        }
        field(3; "Insures(Vendor) No."; Code[20])
        {
            Caption = 'Insures(Vendor) No.';
            DataClassification = CustomerContent;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                CalcFields("Vendor name");
            end;
        }
        field(12; "Vendor name"; text[100])
        {
            FieldClass = FlowField;

            CalcFormula = lookup(Vendor.Name where("No." = field("Insures(Vendor) No.")));
        }

        field(4; "Lincense Plate"; Code[50])
        {
            Caption = 'Lincense Plate';
            DataClassification = CustomerContent;
            TableRelation = "Vehicles IDA" where("Customer No." = field("Insured(Customer) No."));
        }
        field(5; "Accident Date"; Date)
        {
            Caption = 'Accident Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Accident Date" > Today then
                    error('Accidents cannot happen in the future');
            end;
        }
        field(6; Comments; blob)
        {
            Caption = 'Comments';
            DataClassification = CustomerContent;
        }
        field(13; Responsible; Enum "Responsible IDA")
        {
            DataClassification = CustomerContent;
            Caption = 'Responsible for payment';

            trigger OnValidate()
            var
                enum: Enum "Responsible IDA";
            begin
                if rec.Responsible = enum::insured then begin
                    rec."Who will pay" := rec."Customer name";
                end
                else begin
                    rec."Who will pay" := rec."Vendor name";
                end;
            end;
        }
        field(7; "Who will pay"; Text[100])
        {
            Caption = 'Responsible name: ';
            DataClassification = CustomerContent;
        }
        field(8; "Decision Date"; Date)
        {
            Caption = 'Decision Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if rec."Decision Date" < rec."Accident Date" then
                    Error('Decision Date cannot be before accident date');

                if rec."Decision Date" > Today then
                    Error('Decision Date cannot be in the future');
            end;
        }
        field(9; "total Payment"; Decimal)
        {
            Caption = 'Total Payment';
        }
        field(15; "Estimated Payment"; Decimal)
        {
            Caption = 'Estimated total Payment';
        }
        field(10; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if rec."Payment Date" < rec."Decision Date" then
                    Error('Payment Date cannot be before decision date.');

                if rec."Payment Date" > Today then
                    error('Payment Date cannot be in the future.');

            end;

        }
    }

    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
    }

    var
        enumResponsible: enum "Responsible IDA";

    trigger OnInsert()
    var
        NoSeriesCode: Codeunit NoSeriesManagement;
        NoseriesRecord: Record "No. Series";
        newCode: code[20];
    begin

        newcode := 'CLAIM';
        NoseriesRecord.SetRange(Code, newCode);
        if rec."Document No." = '' then begin
            if NoseriesRecord.FindFirst() then begin
                rec."Document No." := NoSeriesCode.GetNextNo(newCode, today, true);
            end
            else begin
                rec."Document No." := NoSeriesCode.GetNextNo('FA-INS', today, true);
            end;
        end;
    end;


}
