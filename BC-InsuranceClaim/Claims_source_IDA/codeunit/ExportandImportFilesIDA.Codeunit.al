
codeunit 55102 "Export and Import Files IDA"
{
    /// <summary>
    /// MyProcedure.
    /// </summary>
    /// <param name="entryNo">integer.</param>
    /// <param name="claimNo">code[20].</param>
    procedure InsertMediaSetInTheAttachmentsTable(entryNo: integer; claimNo: code[20]; fromFileName: Text; inStream: InStream)
    var
        attachmentsIDA: Record "attachments IDA";
    begin
        attachmentsIDA.Init();
        attachmentsIDA."Entry No." := entryNo;
        attachmentsIDA.Date := today();
        attachmentsIDA."Claim Document No." := claimNo;
        attachmentsIDA.Documents.ImportStream(InStream, FromFileName);
        attachmentsIDA."Document Description" := FromFileName;
        attachmentsIDA.Insert();
    end;

    procedure ExportMediaFromOneClaimDocument(var attachments: Record "attachments IDA")
    var
        TenantMedia: Record "Tenant Media";
        DataCompression: Codeunit "Data Compression";
        TempBlob: Codeunit "Temp Blob";
        InStream: InStream;
        i, j, totalCounter : Integer;
        OutStream: OutStream;
        FileName, zipfileName : Text;
    begin
        totalCounter := attachments.Count;
        ZipFileName := attachments."Claim Document No." + '.zip';
        DataCompression.CreateZipArchive();

        for i := 1 to totalCounter do begin
            j := 1;

            for j := 1 to attachments.documents.count do begin
                ExportFromAFileFromAMediaSet(InStream, attachments, j, DataCompression);
            end;
            
            attachments.Next();
        end;


        TempBlob.CreateOutStream(OutStream);
        DataCompression.SaveZipArchive(OutStream);
        TempBlob.CreateInStream(InStream);
        DownloadFromStream(InStream, '', '', '', ZipFileName);
    end;

    procedure ExportFromAFileFromAMediaSet(InStream: InStream; var attachments: Record "attachments IDA"; j: integer; var dataCompression: Codeunit "Data Compression")
    var
        tenantMedia: Record "Tenant Media";
        fileName: text;
    begin
        if TenantMedia.Get(attachments.Documents.Item(j)) then begin
            TenantMedia.CalcFields(Content);
            if TenantMedia.Content.HasValue then begin
                Clear(InStream);
                TenantMedia.Content.CreateInStream(InStream);
                FileName := StrSubstNo(format(j) + TenantMedia.Description, j);
                DataCompression.AddEntry(InStream, FileName);
            end;
        end;
    end;

    procedure ExportMediaSet(var rec: record "attachments IDA")
    var
        TenantMedia: Record "Tenant Media";
        DataCompression: Codeunit "Data Compression";
        TempBlob: Codeunit "Temp Blob";
        InStreamPic: InStream;
        i, totalCounter : Integer;
        OutStream: OutStream;
        FileName, zipFileName : Text;
    begin

        totalCounter := rec.Documents.count;
        ZipFileName := rec."Claim Document No." + '_' + format(rec."Entry No.") + '.zip';
        DataCompression.CreateZipArchive();

        for i := 1 to totalCounter do begin
            ExportFromAFileFromAMediaSet(InStreamPic, rec, i, DataCompression);
        end;

        TempBlob.CreateOutStream(OutStream);
        DataCompression.SaveZipArchive(OutStream);
        TempBlob.CreateInStream(InStreamPic);
        DownloadFromStream(InStreamPic, '', '', '', ZipFileName);
    end;
}
