/// <summary>
/// TableExtension "Item_Ext" (ID 50103) extends Record item.
/// </summary>
tableextension 50103 Item_Ext extends item
{
    fields
    {
        field(50100; "Item CRM Description"; Blob)
        {
            Caption = 'Item CRM Description';
            DataClassification = ToBeClassified;
        }
        field(50101; "Item CRM Description1"; Text[2000])
        {
            Caption = 'Item CRM Description';
            DataClassification = ToBeClassified;
        }
    }
}
