page 55104 "Unprocessed Claim IDA"
{
    ApplicationArea = All;
    Caption = 'Claim';
    PageType = Card;
    SourceTable = "Unprocessed Claims Header IDA";


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
                    Editable = false;
                }
                group(Customer)
                {

                    field("Insured(Customer) No."; Rec."Insured(Customer) No.")
                    {
                        ToolTip = 'Specifies the value of the Insured(Customer) No. field.';
                        ShowMandatory = true;
                    }
                    field("Customer name"; Rec."Customer name")
                    {
                        ToolTip = 'Specifies the value of the Insured(Customer) Name field.';
                    }
                    field("Lincense Plate"; Rec."Lincense Plate")
                    {
                        ToolTip = 'Specifies the value of the Lincense Plate field.';
                        ShowMandatory = true;

                    }
                }

                group(Vendor)
                {
                    field("Insures(Vendor) No."; Rec."Insures(Vendor) No.")
                    {
                        ToolTip = 'Specifies the value of the Insures(Vendor) No. field.';
                        ShowMandatory = true;
                    }

                    field("Vendor name"; Rec."Vendor name")
                    {
                        ToolTip = 'Specifies the value of the Vendor name field.';
                    }
                }

                group(Accident)
                {
                    field("Accident Date"; Rec."Accident Date")
                    {
                        ToolTip = 'Specifies the value of the Accident Date field.';
                        ShowMandatory = true;
                    }
                    field(Comments; CommentsText)
                    {
                        ToolTip = 'Specifies the value of the Comments field.';
                        MultiLine = true;
                        ExtendedDatatype = RichContent;

                        trigger OnValidate()
                        begin
                            setRichContent();
                        end;

                    }
                }

                group(Decision)
                {
                    field("Decision Date"; Rec."Decision Date")
                    {
                        ToolTip = 'Specifies the value of the Decision Date field.';
                        ShowMandatory = true;
                    }
                    field("Payment Date"; Rec."Payment Date")
                    {
                        ToolTip = 'Specifies the value of the Payment Date field.';
                    }
                    field(Responsible; Rec.Responsible)
                    {
                        ToolTip = 'Specifies the value of the Responsible field.';
                    }
                    field("Who will pay"; Rec."Who will pay")
                    {
                        ToolTip = 'Specifies the value of the Who will pay? field.';
                        Editable = false;
                    }
                    field("total Payment"; Rec."total Payment")
                    {
                        ToolTip = 'Specifies the value of the total Payment field.';
                    }
                    field("Estimated Cost"; rec."Estimated Payment")
                    {
                        ToolTip = 'Specifies the value of the estimated Payment field.';
                        Editable = false;

                    }
                }

            }

            part(UnprocessedClaims; "Unprocessed Claims list IDA")
            {
                SubPageLink = "Document No." = field("Document No.");
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
                        Close();
                    end;
                end;
            }
        }

    }
    var
        postingClaims: Codeunit "Posting Claims IDA";
        CommentsText: text;

    trigger OnAfterGetRecord()
    begin
        GetRichContent();
    end;

    local procedure setRichContent()
    var
        outStream: OutStream;
    begin
        rec.Comments.CreateOutStream(outStream, TextEncoding::UTF8);
        outStream.WriteText(CommentsText);
        rec.Modify(true);
    end;

    local procedure GetRichContent()
    var
        inStreamText: InStream;
    begin
        clear(CommentsText);
        rec.CalcFields(Comments);
        if rec.Comments.HasValue() then begin
            rec.Comments.CreateInStream(inStreamtext, TextEncoding::UTF8);
            inStreamtext.Read(CommentsText)
        end;
    end;
}

