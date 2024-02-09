page 55120 "Atta. FactBox Processed IDA"
{
    ApplicationArea = All;
    Caption = 'Attachments FactBox';
    PageType = ListPart;
    SourceTable = "attachments IDA";
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
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Claim Document No."; Rec."Claim Document No.")
                {
                    ToolTip = 'Specifies the value of the Claim Document No. field.';
                }
                field("Document Description"; Rec."Document Description")
                {
                    ToolTip = 'Specifies the value of the Document Description field.';
                }
                field(Documents; Rec.Documents)
                {
                    ToolTip = 'Specifies the value of the Documents field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ExportMedia)
            {
                ApplicationArea = All;
                Caption = 'Export files';

                Image = Export;

                trigger OnAction()
                var
                    attachments: record "attachments IDA";
                begin

                    attachments.SetRange("Claim Document No.", rec."Claim Document No.");
                    if not attachments.FindSet() then
                        exit;

                    importExport.ExportMediaFromOneClaimDocument(attachments);
                end;
            }
        }

    }
    var
        importExport: Codeunit "Export and Import Files IDA";
}
