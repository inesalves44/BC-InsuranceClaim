page 55106 "Unprocessed Claims List IDA"
{
    ApplicationArea = All;
    Caption = 'Unprocessed Claims List';
    PageType = ListPart;
    SourceTable = "Unprocessed Claims Lines IDA";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; rec."Document No.")
                {
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = FALSE;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("item Name"; rec."Item Name")
                {
                    ToolTip = 'Specifies the value of the Item name field.';
                }
                field(Damage; rec.Damage)
                {
                    ToolTip = 'Specifies the value of the Damage field.';

                }
                field("estimated Cost"; Rec."estimated unit Cost")
                {
                    ToolTip = 'Specifies the value of the estimated cost field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the quantity field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Estimated Total Cost"; rec."Estimated Total Cost")
                {
                    ToolTip = 'Specifies the value of the estimated total cost field.';
                }
            }
        }
    }


}
