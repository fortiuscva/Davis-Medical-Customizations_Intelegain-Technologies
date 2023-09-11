/// <summary>
/// PageExtension Customer Card_Ext (ID 50101) extends Record Customer Card.
/// </summary>
pageextension 50101 "Customer Card_Ext" extends "Customer Card"
{
    layout
    {
        addafter(Name)
        {
            field("CRM Account ID"; Rec."CRM Account ID")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Sales Order Exists"; Rec."Sales Order Exists")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
}
