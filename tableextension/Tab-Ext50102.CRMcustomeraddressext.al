/// <summary>
/// TableExtension CRM customeraddress_ext (ID 50102) extends Record CRM Customeraddress.
/// </summary>
tableextension 50102 "CRM customeraddress_ext" extends "CRM Customeraddress"
{
    fields
    {
        field(50000; ikl_LinkID; Text[100])
        {
            ExternalName = 'ikl_linkid';
            ExternalType = 'String';
            Description = 'to store link id';
            Caption = 'Link ID';
        }
    }
}

