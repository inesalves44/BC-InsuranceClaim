page 55102 "Vehicles card IDA"
{
    ApplicationArea = All;
    Caption = 'Vehicles card';
    PageType = Card;
    SourceTable = "Vehicles IDA";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field(Customer; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer field.';
                }
                field("License Plate"; Rec."License Plate")
                {
                    ToolTip = 'Specifies the value of the License Plate field.';
                }
                field(Model; Rec.Model)
                {
                    ToolTip = 'Specifies the value of the Model  field.';
                }
            }
        }
    }
}
