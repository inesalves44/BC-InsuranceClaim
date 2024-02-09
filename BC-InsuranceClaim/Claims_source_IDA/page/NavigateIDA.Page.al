page 50103 "Navigate IDA"
{
    ApplicationArea = All;
    Caption = 'Navigate';
    PageType = List;
    SourceTable = "Documents Claims IDA";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Table Name"; Rec."Table Name")
                {
                    ToolTip = 'Specifies the value of the Table Name field.';

                    trigger OnDrillDown()
                    begin
                        OpenPageWithFilter();
                    end;
                }
                field("Referes To"; Rec."Referes to")
                {
                    ToolTip = 'Specifies the value of the Referes to field.';
                }
                field("Count Records"; Rec."Count Records")
                {
                    ToolTip = 'Specifies the value of the Count Records field.';
                }
            }
        }
    }

    local procedure OpenPageWithFilter()
    var
        claimsLedgerEntries: record "Claims Ledger Entries IDA";
        processedClaims: record "Processed Claims Header IDA";
        unprocessedClaims: Record "Unprocessed Claims Header IDA";
    begin
        claimsLedgerEntries.Reset();
        processedClaims.Reset();
        unprocessedClaims.Reset();

        case rec."Table Name" of
            'Customer Claims Ledger Entries':
                begin
                    claimsLedgerEntries.setrange("Document No.", rec."Document No.");
                    Page.run(page::"Cust. Claims Led. Entries IDA", claimsLedgerEntries);
                end;

            'Vendor Claims Ledger Entries':
                begin
                    claimsLedgerEntries.setrange("Document No.", rec."Document No.");
                    if not claimsLedgerEntries.IsEmpty then begin
                        Page.run(page::"Vendors Claims Ledger Entries", claimsLedgerEntries);
                    end
                    else
                        Error('No records for this filter');

                end;
            'Customer processed Claims':
                begin
                    processedClaims.SetRange("Insured(Customer) No.", rec."Customer NO.");
                    if not processedClaims.IsEmpty then begin
                        Page.Run(Page::"Processed Claims List IDA", processedClaims);
                    end
                    else
                        Error('No records for this filter');
                end;
            'Vendor processed Claims':
                begin
                    processedClaims.SetRange("Insures(Vendor) No.", rec."Vendor NO.");
                    if not processedClaims.IsEmpty then begin
                        Page.Run(Page::"Processed Claims List IDA", processedClaims);
                    end
                    else
                        Error('No records for this filter');
                end;
            'Customer unprocessed Claims':
                begin
                    unprocessedClaims.SetRange("Insured(Customer) No.", rec."Customer NO.");
                    if not unprocessedClaims.IsEmpty then begin
                        Page.Run(Page::"unprocessed Claims IDA", unprocessedClaims);
                    end
                    else
                        Error('No records for this filter');
                end;
            'Vendor unprocessed Claims':
                begin
                    unprocessedClaims.SetRange("Insures(Vendor) No.", rec."Vendor NO.");
                    if not unprocessedClaims.IsEmpty then begin
                        Page.Run(Page::"unprocessed Claims IDA", unprocessedClaims);
                    end
                    else
                        Error('No records for this filter');

                end;
        end;
    end;

}
