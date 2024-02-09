page 55103 "Unprocessed Claims IDA"
{
    ApplicationArea = All;
    Caption = 'Claims';
    PageType = List;
    SourceTable = "Unprocessed Claims Header IDA";
    UsageCategory = Lists;
    CardPageId = "Unprocessed Claim IDA";

    layout
    {
        area(content)
        {
            repeater(General)
            {
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
                field("Customer name"; Rec."Customer name")
                {
                    ToolTip = 'Specifies the value of the Insured(Customer) Name field.';
                }
                field("Vendor name"; Rec."Vendor name")
                {
                    ToolTip = 'Specifies the value of the Vendor name field.';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.';
                }
                field("Accident Date"; Rec."Accident Date")
                {
                    ToolTip = 'Specifies the value of the Accident Date field.';
                }
                field("Decision Date"; Rec."Decision Date")
                {
                    ToolTip = 'Specifies the value of the Decision Date field.';
                }
                field("Who will pay"; Rec."Who will pay")
                {
                    ToolTip = 'Specifies the value of the Who will pay? field.';
                }
                field("total Payment"; Rec."total Payment")
                {
                    ToolTip = 'Specifies the value of the total Payment field.';
                }
                field(Responsible; Rec.Responsible)
                {
                    ToolTip = 'Specifies the value of the Responsible field.';
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    ToolTip = 'Specifies the value of the Payment Date field.';
                }
                field("Lincense Plate"; Rec."Lincense Plate")
                {
                    ToolTip = 'Specifies the value of the Lincense Plate field.';
                }
            }
        }
        area(FactBoxes)
        {
            part(AttatchmentsFactBox; "Attatchments FactBox IDA")
            {
                Caption = 'Attatchments';
                ApplicationArea = basic, suite;
                SubPageLink = "Claim Document No." = field("Document No.");
                UpdatePropagation = SubPart;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Post)
            {
                ApplicationArea = All;
                Image = Post;

                trigger OnAction()
                var
                    Text00: label 'Do you want to post claim number %1?';
                begin
                    if Dialog.Confirm(text00, true, rec."Document No.") then begin
                        postingClaims.PostInsuranceClaims(rec);
                    end;
                end;
            }
        }

    }
    var
        postingClaims: Codeunit "Posting Claims IDA";

}
