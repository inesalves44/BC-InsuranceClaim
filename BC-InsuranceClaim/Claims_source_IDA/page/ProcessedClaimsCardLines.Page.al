page 55114 "Processed Claims Card Lines"
{
    ApplicationArea = All;
    Caption = 'Processed Claims Card Lines';
    PageType = ListPart;
    SourceTable = "Processed Claims Lines IDA";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                    Visible = false;
                }

                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Item Name"; Rec."Item Name")
                {
                    ToolTip = 'Specifies the value of the Item Name field.';
                }
                field(Damage; Rec.Damage)
                {
                    ToolTip = 'Specifies the value of the Damage field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Estimated Total Cost"; Rec."Estimated Total Cost")
                {
                    ToolTip = 'Specifies the value of the Estimated Total Cost field.';
                }
            }
        }
    }
}
