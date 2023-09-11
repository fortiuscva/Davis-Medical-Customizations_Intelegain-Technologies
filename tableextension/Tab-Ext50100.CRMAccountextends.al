/// <summary>
/// TableExtension CRM Account_extends extends Record CRM Account.
/// </summary>
tableextension 50100 "CRM Account_extends" extends "CRM Account"
{
    fields
    {
        field(50150; itl_BCCustCode; Text[100])
        {
            ExternalName = 'itl_bccustcode';
            ExternalType = 'String';
            Description = '';
            Caption = 'BC Cust Code';
        }
        field(50151; itl_BCCustID; Text[100])
        {
            ExternalName = 'itl_bccustid';
            ExternalType = 'String';
            Description = '';
            Caption = 'BC Cust ID';
        }
        field(50152; new_NoofSOs; Integer)
        {
            ExternalName = 'new_noofsos';
            ExternalType = 'Integer';
            Description = '';
            Caption = 'No of Sales Orders';
        }

        field(50153; itl_salesorderexists; Boolean)
        {
            ExternalName = 'itl_salesorderexists';
            ExternalType = 'Boolean';
            Description = '';
            Caption = 'Sales Order Exists';
        }
    }
}