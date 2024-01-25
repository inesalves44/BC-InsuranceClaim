page 55107 "Attatchments FactBox IDA"
{
    ApplicationArea = All;
    Caption = 'Attatchments FactBox';
    PageType = ListPart;
    SourceTable = "attachments IDA";
    CardPageId = "Attachments card IDA";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("entry NO."; rec."Entry No.")
                {
                    ApplicationArea = All;
                }

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
            action(ImportMedia)
            {
                ApplicationArea = All;
                Caption = 'Import Docs';
                Image = Import;

                trigger OnAction()
                var
                    FromFileName: Text;
                    InStreamPic: Instream;
                    attachmentsTestIDA: Record "attachments IDA";
                begin

                    if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FromFileName, InStreamPic) then begin
                        if attachmentsTestIDA.FindLast() then begin
                            importExport.InsertMediaSetInTheAttachmentsTable(attachmentsTestIDA."Entry No." + 1, rec."Claim Document No.", FromFileName, InStreamPic);
                        end
                        else
                            importExport.InsertMediaSetInTheAttachmentsTable(1, rec."Claim Document No.", FromFileName, InStreamPic);
                    end;
                end;
            }

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
