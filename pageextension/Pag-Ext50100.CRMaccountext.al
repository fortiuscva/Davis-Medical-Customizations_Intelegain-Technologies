/// <summary>
/// PageExtension CRM account(ID 50001) extends Record CRM Account List.
/// </summary>
pageextension 50100 "CRM account_ext" extends "CRM Account List"
{
    layout
    {
        addafter(Address1_Country)
        {
            field(itl_BC_ID; rec.itl_BCCustID) { ApplicationArea = all; }
            field(itl_BC_Code; rec.itl_BCCustCode) { ApplicationArea = all; }
        }
    }
}
