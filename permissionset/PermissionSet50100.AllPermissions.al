/// <summary>
/// Unknown All Permissions (ID 50100).     
/// </summary>    
permissionset 50100 "All Permissions"
{
    Assignable = true;
    Permissions = tabledata "Davis customer history" = RIMD,
        table "Davis customer history" = X,
        table "Ship-to Address" = X,
tabledata "ship-to address" = RMID,
        codeunit D365_Events = X,
    // page "CDS CustomerAddress List" = X,
        page "Sales History DM" = X,
        tabledata "CDS CustomerAddress" = RIMD,
        table "CDS CustomerAddress" = X;
    // codeunit Customer_Shiptoaddress_Event = X;
}