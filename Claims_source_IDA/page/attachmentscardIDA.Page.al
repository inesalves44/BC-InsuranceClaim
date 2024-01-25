page 55111 "attachments card IDA"
{
    ApplicationArea = All;
    Caption = 'Attachments Card';
    PageType = Card;
    SourceTable = "attachments IDA";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                    Editable = false;
                }
                field("Document Description"; Rec."Document Description")
                {
                    ToolTip = 'Specifies the value of the Document Description field.';
                    Editable = false;
                }
                field("Claim Document No."; Rec."Claim Document No.")
                {
                    ToolTip = 'Specifies the value of the Claim Document No. field.';
                    Editable = false;
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
            action(Exportfile)
            {
                ApplicationArea = All;
                Caption = 'Export media set files';

                Image = Export;

                trigger OnAction()
                begin

                    if rec.documents.Count = 0 then
                        exit;

                    exportAndImpoortFiles.ExportMediaSet(rec);
                end;
            }

            action(AddMedia)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    insStream: InStream;
                    fromfilename: text;
                begin
                    if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FromFileName, insStream) then begin
                        rec.Documents.ImportStream(insStream, fromfilename);
                        rec.Modify();
                    end;
                end;
            }
        }
    }
    var
        exportAndImpoortFiles: Codeunit "Export and Import Files IDA";
}
