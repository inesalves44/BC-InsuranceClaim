/// <summary>
/// Table Documents Claims IDA (ID 50102).
/// </summary>
table 50102 "Documents Claims IDA"
{
    Caption = 'Documents Claims';
    DataClassification = CustomerContent;
    TableType = Temporary;

    fields
    {
        field(2; "Table Name"; Text[100])
        {
            Caption = 'Table Name';
        }
        field(3; "Count Records"; Integer)
        {
            Caption = 'Count Records';
        }
        field(4; "Document No."; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Customer NO."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Vendor No."; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Referes to"; Text[50])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Table Name")
        {
            Clustered = true;
        }
    }


    local procedure GetLedgerEntries(denominationText: text; var processedClaim: Record "Processed Claims Header IDA")
    var
        ClaimsLedgerEntries: record "Claims Ledger Entries IDA";
    begin
        rec."Document No." := processedClaim."Document No.";
        rec."Table Name" := denominationText + ' Claims Ledger Entries';
        rec."Count Records" := 1;
        rec."Referes to" := 'Document Number: ' + processedClaim."Document No.";
        rec."Vendor No." := processedClaim."Insures(Vendor) No.";
        rec."Customer NO." := processedClaim."Insured(Customer) No.";
        rec.Insert();
    end;

    local procedure GetProcessedClaimsValues(denominationText: text; var processedClaim: Record "Processed Claims Header IDA")
    var
        allprocessedClaim: Record "Processed Claims Header IDA";
    begin
        if denominationText = 'Customer' then begin
            allprocessedClaim.SetRange("Insured(Customer) No.", processedClaim."Insured(Customer) No.");
            rec."referes to" := denominationText + ' Number ' + processedClaim."Insured(Customer) No.";
        end
        else begin
            allprocessedClaim.SetRange("Insures(Vendor) No.", processedClaim."Insures(Vendor) No.");
            rec."referes to" := denominationText + ' Number ' + processedClaim."Insures(Vendor) No.";
        end;
        rec."Table Name" := denominationText + ' processed Claims';
        rec."Customer NO." := processedClaim."Insured(Customer) No.";
        rec."Vendor No." := processedClaim."Insures(Vendor) No.";
        rec."Count Records" := allprocessedClaim.Count;
        rec.Insert();
    end;

    local procedure GetUnprocessedClaimsValues(denominationText: text; var processedClaim: Record "Processed Claims Header IDA")
    var
        unprocessedClaim: Record "unprocessed Claims Header IDA";
    begin
        if denominationText = 'Customer' then begin
            unprocessedClaim.SetRange("Insured(Customer) No.", processedClaim."Insured(Customer) No.");
            rec."referes to" := denominationText + ' Number ' + processedClaim."Insured(Customer) No.";
        end
        else begin
            unprocessedClaim.SetRange("Insures(Vendor) No.", processedClaim."Insures(Vendor) No.");
            rec."referes to" := denominationText + ' Number ' + processedClaim."Insures(Vendor) No.";
        end;
        rec."Table Name" := denominationText + ' unprocessed Claims';
        rec."Customer NO." := processedClaim."Insured(Customer) No.";
        rec."Vendor No." := processedClaim."Insures(Vendor) No.";
        rec."Count Records" := unprocessedClaim.Count;
        rec.Insert();
    end;

    /// <summary>
    /// GetDocuments.
    /// </summary>
    /// <param name="processedClaim">Record "Processed Claims Header IDA".</param>
    procedure GetDocuments(var processedClaim: Record "Processed Claims Header IDA")
    var
        allUnprocessedClaim: record "Unprocessed Claims Header IDA";
    begin
        GetLedgerEntries('Vendor', processedClaim);
        GetLedgerEntries('Customer', processedClaim);

        GetProcessedClaimsValues('Customer', processedClaim);
        GetProcessedClaimsValues('Vendor', processedClaim);


        GetUnprocessedClaimsValues('Customer', processedClaim);
        GetUnprocessedClaimsValues('Vendor', processedClaim);
    end;
}
