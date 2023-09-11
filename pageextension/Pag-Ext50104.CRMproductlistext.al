/// <summary>
/// PageExtension CRM product list_ext (ID 50104) extends Record CRM Product List.
/// </summary>
pageextension 50104 "CRM product list_ext" extends "CRM Product List"
{

    layout
    {
        addafter(Name)
        {
            field(Description; Rec.Description)
            { ApplicationArea = all; }
        }
    }

    actions
    {
        addafter(ShowOnlyUncoupled)
        {
            action("test")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    RecRef: RecordRef;
                    RecID: RecordID;
                    varTableNumber: Integer;
                    crmproduct: Record "CRM Product";
                    tableno: Integer;
                    Item: Record Item;
                    PicText: Text;
                    PicInstr: InStream;
                    TempBlob: Codeunit "Temp Blob";
                    PicOStr: OutStream;
                    Base64: Codeunit "Base64 Convert";
                begin
                    varTableNumber := crmproduct.RecordId.TableNo;
                    Message(Format(varTableNumber));
                    tableno := 5348;
                    if varTableNumber = tableno then begin
                        crmproduct.CalcFields(Description);
                        if crmproduct.Description.HasValue then begin
                            Clear(PicText);
                            Clear(PicInstr);
                            Clear(PicOStr);
                            TempBlob.CreateInStream(PicInstr);
                            TempBlob.CreateOutStream(PicOStr);
                            crmproduct.Description.CreateInStream(PicInstr);
                            PicInstr.Read(PicText);
                            Message(PicText);
                        end;
                    end;
                end;
            }
        }
    }
}
