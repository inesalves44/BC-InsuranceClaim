page 55118 "Processed Claims List IDA"
{
    ApplicationArea = All;
    Caption = 'Processed Claims List';
    PageType = List;
    SourceTable = "Processed Claims Header IDA";
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    CardPageId = "Processed Claim Card IDA";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Accident Date"; Rec."Accident Date")
                {
                    ToolTip = 'Specifies the value of the Accident Date field.';
                }
                field("Decision Date"; Rec."Decision Date")
                {
                    ToolTip = 'Specifies the value of the Decision Date field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Insured(Customer) No."; Rec."Insured(Customer) No.")
                {
                    ToolTip = 'Specifies the value of the Insured(Customer) No. field.';
                }
                field("Insures(Vendor) No."; Rec."Insures(Vendor) No.")
                {
                    ToolTip = 'Specifies the value of the Insures(Vendor) No. field.';
                }
                field("Lincense Plate"; Rec."Lincense Plate")
                {
                    ToolTip = 'Specifies the value of the Lincense Plate field.';
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    ToolTip = 'Specifies the value of the Payment Date field.';
                }
                field("total Payment"; Rec."total Payment")
                {
                    ToolTip = 'Specifies the value of the total Payment field.';
                }
                field("Responsible Name"; Rec."Who will pay")
                {
                    ToolTip = 'Specifies the party responsible for the payment.';
                }
            }
        }
        area(FactBoxes)
        {
            part(AttatchmentsFactBox; "Atta. FactBox Processed IDA")
            {
                Caption = 'Attatchments';
                ApplicationArea = basic, suite;
                SubPageLink = "Claim Document No." = field("Document No.");
                UpdatePropagation = SubPart;
            }
        }
    }

}
