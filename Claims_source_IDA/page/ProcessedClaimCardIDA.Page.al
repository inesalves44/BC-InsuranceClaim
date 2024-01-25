page 55122 "Processed Claim Card IDA"
{
    ApplicationArea = All;
    Caption = 'Processed Claim Card';
    PageType = Card;
    SourceTable = "Processed Claims Header IDA";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                group(Customer)
                {
                    field("Insured(Customer) No."; Rec."Insured(Customer) No.")
                    {
                        ToolTip = 'Specifies the value of the Insured(Customer) No. field.';
                    }
                    field("Customer name"; Rec."Customer name")
                    {
                        ToolTip = 'Specifies the value of the Insured(Customer) Name field.';
                    }
                    field("Lincense Plate"; Rec."Lincense Plate")
                    {
                        ToolTip = 'Specifies the value of the Lincense Plate field.';
                    }

                }
                group(vendor)
                {
                    field("Insures(Vendor) No."; Rec."Insures(Vendor) No.")
                    {
                        ToolTip = 'Specifies the value of the Insures(Vendor) No. field.';
                    }
                    field("Vendor name"; Rec."Vendor name")
                    {
                        ToolTip = 'Specifies the value of the Vendor name field.';
                    }
                }

                group(Closed)
                {

                    field(Responsible; Rec.Responsible)
                    {
                        ToolTip = 'Specifies the value of the Responsible field.';
                    }
                    field("Accident Date"; Rec."Accident Date")
                    {
                        ToolTip = 'Specifies the value of the Accident Date field.';
                    }
                    field("Payment Date"; Rec."Payment Date")
                    {
                        ToolTip = 'Specifies the value of the Payment Date field.';
                    }
                    field("total Payment"; Rec."total Payment")
                    {
                        ToolTip = 'Specifies the value of the total Payment field.';
                    }
                    field(Comments; rec.Comments)
                    {
                        ToolTip = 'Specifies the value of the Comments field.';
                        MultiLine = true;
                    }
                }
            }

            part(ProcessedClaimLines; "Processed Claims Card Lines")
            {
                SubPageLink = "Document No." = field("Document No.");
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
