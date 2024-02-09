codeunit 55101 "Posting Claims IDA"
{
    /// <summary>
    /// PostInsuranceClaims.
    /// </summary>
    /// <param name="unprocessedClaim">Record "Unprocessed Claims Header IDA".</param>
    procedure PostInsuranceClaims(unprocessedClaim: Record "Unprocessed Claims Header IDA")
    var
        unprocessedClaimLines: record "Unprocessed Claims Lines IDA";
        totalCost: Decimal;
    begin
        unprocessedClaimLines.setrange("Document No.", unprocessedClaim."Document No.");
        if unprocessedClaimLines.IsEmpty() then begin
            if not Dialog.Confirm('Claim number %1 does not have any Items associated do you still want to post?', true, unprocessedClaim."Document No.") then
                exit;
        end;

        if unprocessedClaimLines.FindSet() then;

        CheckMandatoryFieldsClaimHeader(unprocessedClaim);
        CheckMandatoryFieldsClaimLines(unprocessedClaimLines, unprocessedClaim."Document No.");

        totalCost := CopyClaimsHeaderToProcessed(unprocessedClaim);

        CopyClaimsLinesToProcessed(unprocessedClaimLines, unprocessedClaim."Document No.");
        CopyLedgerEntries(unprocessedClaim, totalCost);

        DeleteClaimLines(unprocessedClaimLines);
        DeleteClaimHeader(unprocessedClaim);
    end;

    local procedure CheckMandatoryFieldsClaimHeader(unprocessedClaim: Record "Unprocessed Claims Header IDA")
    var
        enumResponsible: enum "Responsible IDA";
        result: Boolean;
    begin

        result := false;

        if unprocessedClaim."Insured(Customer) No." = '' then
            error('Cannot process a claim without customer no.');
        if unprocessedClaim."Insured(Customer) No." = '' then
            error('Cannot process a claim without customer no.');
        if unprocessedClaim."Lincense Plate" = '' then
            error('Cannot process a claim without license plate');
        if unprocessedClaim."Accident Date" = 0D then
            error('Cannot process a claim without an accident date');
        if (unprocessedClaim.Responsible = enumResponsible::Blank) or (unprocessedClaim."Decision Date" = 0D) then begin
            error('To close a claim there has to be a responsible party and decision date');
        end;
        if (unprocessedClaim."total Payment" = 0) and (unprocessedClaim."Estimated Payment" = 0) then
            error('The cost of the claim cannot be zero');
    end;

    local procedure CheckMandatoryFieldsClaimLines(unprocessedClaimsLines: Record "Unprocessed Claims Lines IDA"; claimDocument: code[20])
    begin
        unprocessedClaimsLines.SetRange("Document No.", claimDocument);
        if unprocessedClaimsLines.FindSet() then
            repeat
                if (unprocessedClaimsLines."Item No." = '') or (unprocessedClaimsLines.Quantity = 0) then
                    error('Missing information on item line!');
            until unprocessedClaimsLines.next() = 0;
    end;

    local procedure CopyClaimsHeaderToProcessed(unprocessedClaimHeader: record "Unprocessed Claims Header IDA"): decimal
    var
        processedClaimHeader: record "Processed Claims Header IDA";
    begin
        processedClaimHeader.init();
        processedClaimHeader.TransferFields(unprocessedClaimHeader);
        processedClaimHeader."Customer name" := unprocessedClaimHeader."Customer name";
        processedClaimHeader."Vendor name" := unprocessedClaimHeader."Vendor name";
        if unprocessedClaimHeader."total Payment" = 0 then
            processedClaimHeader."total Payment" := unprocessedClaimHeader."Estimated Payment";
        processedClaimHeader.Insert(true);
        exit(processedClaimHeader."total Payment");
    end;

    local procedure CopyClaimsLinesToProcessed(var unprocessedClaimLines: record "Unprocessed Claims lines IDA"; ClaimCode: code[20])
    var
        processedClaimLines: Record "Processed Claims Lines IDA";
        items: Record Item;
    begin

        if unprocessedClaimLines.FindSet() then begin
            repeat
                items.Reset();
                items.setrange("No.", unprocessedClaimLines."Item No.");
                items.FindFirst();
                processedClaimLines.Init();
                processedClaimLines.TransferFields(unprocessedClaimLines);
                processedClaimLines.Insert(true);
            until unprocessedClaimLines.next() = 0;
        end;

        if unprocessedClaimLines.FindFirst() then;
    end;

    local procedure CopyLedgerEntries(unprocessedClaim: Record "Unprocessed Claims Header IDA"; totalCost: decimal)
    var
        claimsLedgerEntries: Record "Claims Ledger Entries IDA";
    begin
        claimsLedgerEntries.init();
        claimsLedgerEntries."Document No." := unprocessedClaim."Document No.";
        claimsLedgerEntries."Customer NO." := unprocessedClaim."Insured(Customer) No.";
        claimsLedgerEntries."Customer Name" := unprocessedClaim."Customer name";
        claimsLedgerEntries."Vendor No." := unprocessedClaim."Insures(Vendor) No.";
        claimsLedgerEntries."Vendor Name" := unprocessedClaim."Vendor name";
        claimsLedgerEntries."Date Claim" := unprocessedClaim."Accident Date";
        claimsLedgerEntries.Responsible := unprocessedClaim.Responsible;
        claimsLedgerEntries."Total Cost" := totalCost;
        claimsLedgerEntries.Insert();
    end;

    local procedure DeleteClaimLines(var unprocessedClaimsLines: record "Unprocessed Claims Lines IDA")
    begin
        if not unprocessedClaimsLines.IsEmpty() then
            repeat
                unprocessedClaimsLines.Delete()
            until unprocessedClaimsLines.next() = 0;
    end;

    local procedure DeleteClaimHeader(var unprocessedClaimHeader: Record "Unprocessed Claims Header IDA")
    begin
        if not unprocessedClaimHeader.IsEmpty() then
            unprocessedClaimHeader.Delete();
    end;
}
