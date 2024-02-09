codeunit 50105 "Create a Number Series IDA"
{
    subtype = Install;

    local procedure CreateNoSeries()
    var
        nSeries: Record "No. Series";
    begin
        nSeries.Init();
        nSeries.Code := 'CLAIM';
        nSeries.Description := 'Claim number series';
        nSeries."Default Nos." := false;
        nSeries."Manual Nos." := false;
        nSeries."Date Order" := false;
        nSeries.Insert(true);
    end;

    local procedure CreateNoSeriesLine()
    var
        nSeriesLine: Record "No. Series Line";
    begin
        nSeriesLine.Init();
        nSeriesLine."Series Code" := 'CLAIM';
        nSeriesLine."Line No." := 1;
        nSeriesLine."Starting Date" := Today;
        nSeriesLine."Starting No." := 'CL000001';
        nSeriesLine."Ending No." := 'CL999998';
        nSeriesLine."Warning No." := 'CL999970';
        nSeriesLine."Increment-by No." := 1;
        nSeriesLine."Last No. Used" := 'CL000001';
        nSeriesLine.Open := TRUE;
        nSeriesLine."Allow Gaps in Nos." := true;
        nSeriesLine."Sequence Name" := 'CLAIM';
        nSeriesLine.Insert(true);
    end;

    trigger OnInstallAppPerCompany()
    var
        nSeries: Record "No. Series";
    begin
        if nSeries.Get('CLAIM') then
            exit;

        CreateNoSeries();
        CreateNoSeriesLine();

    end;
}
