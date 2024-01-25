table 55109 "Processed Claims Header IDA"
{
    Caption = 'Processed Claims';
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

        }
        field(11; "Customer name"; text[100])
        {
            Caption = 'Insured(Customer) Name';
        }
        field(3; "Insures(Vendor) No."; Code[20])
        {
            Caption = 'Insures(Vendor) No.';
            DataClassification = CustomerContent;

        }
        field(12; "Vendor name"; text[100])
        {
            DataClassification = CustomerContent;
        }

        field(4; "Lincense Plate"; Code[50])
        {
            Caption = 'Lincense Plate';
            DataClassification = CustomerContent;
        }
        field(5; "Accident Date"; Date)
        {
            Caption = 'Accident Date';
            DataClassification = CustomerContent;
        }
        field(6; Comments; text[2048])
        {
            Caption = 'Comments';
            DataClassification = CustomerContent;
        }
        field(13; Responsible; Enum "Responsible IDA")
        {
            DataClassification = CustomerContent;
            Caption = 'Responsible for payment:';
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


        }
        field(9; "total Payment"; Decimal)
        {
            Caption = 'total Payment';
        }
        field(10; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "document No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        responsible: Enum "Responsible IDA";
    begin
        if (rec.Responsible = responsible::Insures) and (rec."Payment Date" = 0D) then
            error('Insures is responsible so payment date cannot be null.');
        if (rec."Payment Date" < rec."Decision Date") then
            error('Payment date cannot be before decision date');
        if (rec."Payment Date" < rec."Accident Date") then
            error('Payment date cannot be before accident date');
        if (rec."Decision Date" < rec."Accident Date") then
            error('decision date cannot be before accident date');
        if (rec."Insured(Customer) No." = '') or (rec."Insures(Vendor) No." = '') or (rec."Lincense Plate" = '') or (rec."Accident Date" = 0D) then
            error('Mandatory fields cannot be empty');
    end;
}
