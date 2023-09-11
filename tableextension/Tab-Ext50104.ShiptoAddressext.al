/// <summary>
/// TableExtension Ship-to Address_ext (ID 50104) extends Record Ship-to Address.
/// </summary>
tableextension 50104 "Ship-to Address_ext" extends "Ship-to Address"
{
    fields
    {
        field(50100; "CRM ID"; text[250])
        {
            Caption = 'CRM ID';
            DataClassification = ToBeClassified;
        }
    }
}
