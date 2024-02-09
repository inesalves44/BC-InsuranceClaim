page 55112 "Vendors Claims Ledger Entries"
{
    ApplicationArea = All;
    Caption = 'Vendors Claims Ledger Entries';
    PageType = List;
    SourceTable = "Claims Ledger Entries IDA";
    SourceTableView = sorting("date claim") order(descending);
    UsageCategory = Lists;
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
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';

                    trigger OnDrillDown()
                    begin
                        rec.OpenDocument();
                    end;
                }
                field("Customer NO."; Rec."Customer NO.")
                {
                    ToolTip = 'Specifies the value of the Customer NO. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field("vendor name"; Rec."vendor name")
                {
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                }
                field("Date Claim"; Rec."Date Claim")
                {
                    ToolTip = 'Specifies the value of the Date Claim field.';
                }
                field("responsible Payment"; Rec.Responsible)
                {
                    ToolTip = 'Specifies the value of the responsible Payment field.';
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ToolTip = 'Specifies the value of the Total Cost field.';
                    StyleExpr = style;
                }
            }
        }
    }

    var
        responsibleEnum: enum "Responsible IDA";
        style: text;

    trigger OnAfterGetRecord()
    begin
        if rec.Responsible = responsibleEnum::Insures then begin
            style := 'unfavorable';
        end
        else begin
            style := 'none';
        end;
    end;
}
