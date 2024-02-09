/// <summary>
/// Table Vehicles IDA (ID 55101).
/// </summary>
table 55101 "Vehicles IDA"
{
    Caption = 'Vehicles';
    DataClassification = CustomerContent;
    DrillDownPageId = "Vehicles list IDA";
    LookupPageId = "Vehicles list IDA";


    fields
    {
        field(1; "License Plate"; Code[50])
        {
            Caption = 'License Plate';
            DataClassification = CustomerContent;
        }
        field(2; Model; Text[100])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CalcFields("Customer Name");
            end;
        }
        field(4; "Customer Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name WHERE("No." = field("Customer No.")));
        }
    }
    keys
    {
        key(PK; "License Plate")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "License Plate", Model)
        {

        }
    }


    trigger OnInsert()
    begin
        if Rec."License Plate" = '' then
            error('License Plate cannot be empty');
    end;
}
