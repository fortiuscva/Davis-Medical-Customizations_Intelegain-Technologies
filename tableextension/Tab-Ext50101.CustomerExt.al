/// <summary>
/// TableExtension "Customer_Ext" (ID 50101) extends Record Customer.
/// </summary>
tableextension 50101 Customer_Ext extends Customer
{
    fields
    {
        field(50100; "CRM Account ID"; Code[50])
        {
            Caption = 'CRM Account ID';
            DataClassification = ToBeClassified;
        }
        field(50101; "Sales Order Exists"; Boolean)
        {
            Caption = 'Sales Order Exists';
            DataClassification = ToBeClassified;
        }
    }
}
