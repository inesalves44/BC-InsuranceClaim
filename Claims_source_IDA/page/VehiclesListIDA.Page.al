page 55101 "Vehicles List IDA"
{
    ApplicationArea = All;
    Caption = 'Vehicles List';
    PageType = List;
    SourceTable = "Vehicles IDA";
    UsageCategory = Lists;
    CardPageId = "Vehicles card IDA";
    Editable = true;
    

    layout
    {
        area(content)
        {
            repeater(General)
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
