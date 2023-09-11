/// <summary>
/// PageExtension Item Card_ext (ID 50103) extends Record Item Card.
/// </summary>
pageextension 50103 "Item Card_ext" extends "Item Card"
{
    layout
    {
        addafter(Description)
        {
            field("Item CRM Description"; rec."Item CRM Description1")
            {
                MultiLine = true;
                ApplicationArea = all;


                trigger OnValidate()
                var
                    OutStream: OutStream;
                begin
                    /*
                    if rec."Item CRM Description1" <> '' then begin
                        Clear(PicText);
                        Clear(PicInstr);
                        Clear(PicOStr);
                        Item.SetRange("No.", rec."No.");
                        if Item.FindFirst() then begin
                            TempBlob.CreateInStream(PicInstr);
                            TempBlob.CreateOutStream(PicOStr);
                            item."Item CRM Description".CreateOutStream(PicOStr);
                            PicOStr.WriteText(REC."Item CRM Description1");
                            PicOStr.WriteText();

                        end;
                    end;
                    item.Modify(true);
                    */
                    Clear(Rec."Item CRM DEscription");
                    Rec."Item CRM DEscription".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                    OutStream.WriteText(rec."Item CRM Description1");
                    Rec.Modify();
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        /*
        item.Reset();
        item.SetRange("No.", rec."No.");
        if item.FindFirst() then begin
            Item.CalcFields("Item CRM DEscription");
            if Item."Item CRM DEscription".HasValue then begin
                Clear(PicText);
                Clear(PicInstr);
                Clear(PicOStr);
                TempBlob.CreateInStream(PicInstr);
                TempBlob.CreateOutStream(PicOStr);
                Item."Item CRM DEscription".CreateInStream(PicInstr);
                PicInstr.Read(PicText);
                rec."Item CRM Description1" := PicText;
            end;
        end;
        */
    end;

    trigger OnAfterGetRecord()
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        Rec.CalcFields("Item CRM Description");
        Rec."Item CRM Description".CreateInStream(InStream, TEXTENCODING::UTF8);
        Rec."Item CRM Description1" := TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), Rec.FieldName("Item CRM Description"));
    end;


    var
        item: Record Item;
        PicText: Text;
        PicInstr: InStream;
        TempBlob: Codeunit "Temp Blob";
        PicOStr: OutStream;
        Base64: Codeunit "Base64 Convert";

}
