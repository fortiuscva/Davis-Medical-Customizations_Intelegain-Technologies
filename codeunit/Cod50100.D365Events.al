/// <summary>
/// Codeunit D365_Events (ID 60000).
/// </summary>
codeunit 50100 "D365_Events"
{
    local procedure SetCoupledFlags()
    var
        CRMIntegrationRecord: Record "CRM Integration Record";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
    begin
        CRMIntegrationRecord.SetRange("Table ID", Database::customer);
        if CRMIntegrationRecord.FindSet() then
            repeat
                CRMIntegrationManagement.SetCoupledFlag(CRMIntegrationRecord, true)
            until CRMIntegrationRecord.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnGetCDSTableNo', '', false, false)]
    local procedure HandleOnGetCDSTableNo(BCTableNo: Integer; var CDSTableNo: Integer; var handled: Boolean)
    begin
        if BCTableNo = Database::customer then begin
            CDSTableNo := Database::"CRM Account";
            handled := true;
        end;

        //Item-prod  //NE 28-12-2022
        if BCTableNo = Database::Item then begin
            CDSTableNo := Database::"CRM Product";
            handled := true;
        end;
    end;
    //NE 28-12-2022



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', false, false)]
    local procedure HandleOnLookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean)
    begin
        if CRMTableID = Database::"CRM Account" then
            Handled := LookupDataverseWorker(SavedCRMId, CRMId, IntTableFilter);
        //NS 28-12-2022

        if CRMTableID = Database::"CRM Product" then
            Handled := LookupCRMAccount(SavedCRMId, CRMId, IntTableFilter);
        //NE 28-12-2022
    end;

    local procedure LookupDataverseWorker(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRM_Account: Record "CRM Account";
        OriginalCRM_Account: Record "CRM Account";
        CRM_accountList: Page "CRM Account List";
    begin
        if not IsNullGuid(CRMId) then begin
            if CRM_Account.Get(CRMId) then
                CRM_accountList.SetRecord(CRM_Account);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCRM_Account.Get(SavedCRMId) then
                    CRM_accountList.SetCurrentlyCoupledCRMAccount(OriginalCRM_Account);
        end;
        CRM_Account.SetView(IntTableFilter);
        CRM_accountList.SetTableView(CRM_Account);
        CRM_accountList.LookupMode(true);
        if CRM_accountList.RunModal = ACTION::LookupOK then begin
            CRM_accountList.GetRecord(CRM_Account);
            CRMId := CRM_Account.SystemId;
            exit(true);
        end;

    end;

    local procedure Lookupcrmaccount(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CRM_product: Record "CRM Product";
        originalCRM_product: Record "CRM Product";
        CRMProduct_list: Page "CRM Product List";
    begin    //NS 28-12-2022
        if not IsNullGuid(CRMId) then begin
            if CRM_product.Get(CRMId) then
                CRMProduct_list.SetRecord(CRM_product);
            if not IsNullGuid(SavedCRMId) then
                if originalCRM_product.Get(SavedCRMId) then
                    CRMProduct_list.SetCurrentlyCoupledCRMProduct(originalCRM_product);
        end;
        CRM_product.SetView(IntTableFilter);
        CRMProduct_list.SetTableView(CRM_product);
        CRMProduct_list.LookupMode(true);
        if CRMProduct_list.RunModal = ACTION::LookupOK then begin
            CRMProduct_list.GetRecord(CRM_product);
            CRMId := CRM_product.SystemId;
            exit(true);
        end;
        exit(false);
        //NE 28-12-2022
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', false, false)]
    local procedure HandleOnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer" temporary);
    var
        CRMSetupDefaults: Codeunit "CRM Setup Defaults";
    begin
        CRMSetupDefaults.AddEntityTableMapping('Customer', Database::customer, TempNameValueBuffer);
        CRMSetupDefaults.AddEntityTableMapping('Customer', Database::"CRM Account", TempNameValueBuffer);
        //NS 28-12-2022
        CRMSetupDefaults.AddEntityTableMapping('Item', Database::Item, TempNameValueBuffer);
        CRMSetupDefaults.AddEntityTableMapping('Item', Database::"CRM product", TempNameValueBuffer);
        //NE 28-12-2022
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Integration Mgt.", 'OnHasCompanyIdField', '', false, false)]
    local procedure HandleOnHasCompanyIdField(TableId: Integer; var HasField: Boolean)
    begin
        if TableId = Database::"CRM Account" then
            HasField := true;


        if TableId = Database::"CRM product" then
            HasField := true;
    end;

    /// <summary>
    /// InsertIntegrationFieldMapping.
    /// </summary>
    /// <param name="IntegrationTableMappingName">Code[20].</param>
    /// <param name="TableFieldNo">Integer.</param>
    /// <param name="IntegrationTableFieldNo">Integer.</param>
    /// <param name="SynchDirection">Option.</param>
    /// <param name="ConstValue">Text.</param>
    /// <param name="ValidateField">Boolean.</param>
    /// <param name="ValidateIntegrationTableField">Boolean.</param>
    procedure InsertIntegrationFieldMapping(IntegrationTableMappingName: Code[20]; TableFieldNo: Integer; IntegrationTableFieldNo: Integer; SynchDirection: Option; ConstValue: Text; ValidateField: Boolean; ValidateIntegrationTableField: Boolean)
    var
        IntegrationFieldMapping: Record "Integration Field Mapping";
    begin
        IntegrationFieldMapping.CreateRecord(IntegrationTableMappingName, TableFieldNo, IntegrationTableFieldNo, SynchDirection,
            ConstValue, ValidateField, ValidateIntegrationTableField);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', false, false)]
    local procedure HandleOnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup")
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        DataverseWorker: Record "CRM Account";
        Customer: Record Customer;
        Item: Record Item;
        CRM_Product: Record "CRM Product";
    begin
        InsertIntegrationFieldMapping('Customer-Account', Customer.FieldNo(SystemId), DataverseWorker.FieldNo(itl_BCCustID), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        // InsertIntegrationFieldMapping('Customer-Account', Customer.FieldNo("CRM Account ID"), DataverseWorker.FieldNo(AccountNumber), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('Customer-Account', Customer.FieldNo("No."), DataverseWorker.FieldNo(AccountNumber), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('Customer-Account', Customer.FieldNo("No."), DataverseWorker.FieldNo(itl_BCCustCode), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('Customer-Account', Customer.FieldNo("Sales Order Exists"), DataverseWorker.FieldNo(itl_salesorderexists), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('Item-Product', Item.FieldNo("Item CRM Description"), CRM_Product.FieldNo(Description), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        //CustomerAdd NS 27-12-2022
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Integration Management", 'OnBeforeHandleCustomIntegrationTableMapping', '', false, false)]
    local procedure HandleCustomIntegrationTableMappingReset(var IsHandled: Boolean; IntegrationTableMappingName: Code[20])
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        DataverseWorker: Record "CRM Account";
        customer: Record "customer";

        Item: Record Item;
        CRM_product: Record "CRM Product";
    begin
        case IntegrationTableMappingName of
            'customer-Account':
                begin
                    InsertIntegrationFieldMapping('customer-Account', customer.FieldNo(SystemId), DataverseWorker.FieldNo(itl_BCCustID), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
                    // InsertIntegrationFieldMapping('customer-Account', customer.FieldNo("CRM Account ID"), DataverseWorker.FieldNo(AccountNumber), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
                    InsertIntegrationFieldMapping('customer-Account', customer.FieldNo("No."), DataverseWorker.FieldNo(AccountNumber), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
                    InsertIntegrationFieldMapping('customer-Account', customer.FieldNo("No."), DataverseWorker.FieldNo(itl_BCCustCode), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
                    InsertIntegrationFieldMapping('customer-Account', customer.FieldNo("Sales Order Exists"), DataverseWorker.FieldNo(itl_salesorderexists), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
                    IsHandled := true;
                end;
            'Item-Product':
                begin
                    InsertIntegrationFieldMapping('Item-Product', Item.FieldNo("Item CRM Description"), CRM_product.FieldNo(Description), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
                end;

        //NE 27-12-2022
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Integration Rec. Synch. Invoke", 'OnBeforeInsertRecord', '', false, false)]
    local procedure HandleOnBeforeInsertRecord(SourceRecordRef: RecordRef; DestinationRecordRef: RecordRef)
    var
        CDSIntegrationMgt: Codeunit "CDS Integration Mgt.";
    begin
        if DestinationRecordRef.Number() = Database::"CRM Account" then
            CDSIntegrationMgt.SetCompanyId(DestinationRecordRef);
        if DestinationRecordRef.Number() = Database::"CRM product" then
            CDSIntegrationMgt.SetCompanyId(DestinationRecordRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Integration Rec. Synch. Invoke", 'OnBeforeModifyRecord', '', false, false)]
    local procedure HandleOnBeforeModifyRecord(SourceRecordRef: RecordRef; DestinationRecordRef: RecordRef)
    var
        CDSIntegrationMgt: Codeunit "CDS Integration Mgt.";
    begin
        if DestinationRecordRef.Number() = Database::"crm account" then
            CDSIntegrationMgt.SetCompanyId(DestinationRecordRef);
        if DestinationRecordRef.Number() = Database::"crm product" then
            CDSIntegrationMgt.SetCompanyId(DestinationRecordRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Integration Rec. Synch. Invoke", 'OnAfterModifyRecord', '', false, false)]
    local procedure HandleOnAfterModifyRecord(SourceRecordRef: RecordRef; DestinationRecordRef: RecordRef)
    var
        CDSIntegrationMgt: Codeunit "CDS Integration Mgt.";
    begin
        if DestinationRecordRef.Number() = Database::"crm account" then
            CDSIntegrationMgt.SetCompanyId(DestinationRecordRef);
        if DestinationRecordRef.Number() = Database::"crm product" then
            CDSIntegrationMgt.SetCompanyId(DestinationRecordRef);

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetCustomerAccountMapping', '', false, false)]
    local procedure HandleOnAfterResetCustomerAccountMapping(IntegrationTableMappingName: Code[20])
    var
        CRMContact: Record "crm account";
        Contact: Record Customer;
        IntegrationFieldMapping: Record "Integration Field Mapping";

    begin
        InsertIntegrationFieldMapping(IntegrationTableMappingName, Contact.FieldNo(SystemId), CRMContact.FieldNo(itl_BCCustID), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping(IntegrationTableMappingName, Contact.FieldNo("No."), CRMContact.FieldNo(itl_BCCustCode), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping(IntegrationTableMappingName, Contact.FieldNo("Sales Order Exists"), CRMContact.FieldNo(itl_salesorderexists), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        // InsertIntegrationFieldMapping(IntegrationTableMappingName, Contact.FieldNo("CRM Account ID"), CRMContact.FieldNo(AccountNumber), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping(IntegrationTableMappingName, Contact.FieldNo("No."), CRMContact.FieldNo(AccountNumber), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Crm Setup Defaults", 'OnResetItemProductMappingOnAfterInsertFieldsMapping', '', false, false)]
    local procedure OnAfterResetItemProductMappingOnAfterInsertFieldsMapping(IntegrationTableMappingName: Code[20])
    var
        CRM_product: Record "CRM product";
        Item: Record "item";
        IntegrationFieldMapping: Record "Integration Field Mapping";
    begin
        InsertIntegrationFieldMapping(IntegrationTableMappingName, Item.FieldNo("Item CRM Description"), CRM_product.FieldNo(Description), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
    end;

    local procedure InsertIntegrationTableMapping(var IntegrationTableMapping: Record "Integration Table Mapping"; MappingName: Code[20]; TableNo: Integer; IntegrationTableNo: Integer; IntegrationTableUIDFieldNo: Integer; IntegrationTableModifiedFieldNo: Integer; TableConfigTemplateCode: Code[10]; IntegrationTableConfigTemplateCode: Code[10]; SynchOnlyCoupledRecords: Boolean)
    begin
        IntegrationTableMapping.CreateRecord(MappingName, TableNo, IntegrationTableNo, IntegrationTableUIDFieldNo, IntegrationTableModifiedFieldNo, TableConfigTemplateCode, IntegrationTableConfigTemplateCode, SynchOnlyCoupledRecords, IntegrationTableMapping.Direction::Bidirectional, 'Dataverse', Codeunit::"CRM Integration Table Synch.", Codeunit::"CDS Int. Table Uncouple");
    end;

    local procedure InsertIntegrationTableMappingscouple(var IntegrationTableMapping: Record "Integration Table Mapping"; MappingName: Code[20]; TableNo: Integer; IntegrationTableNo: Integer; IntegrationTableUIDFieldNo: Integer; IntegrationTableModifiedFieldNo: Integer; TableConfigTemplateCode: Code[10]; IntegrationTableConfigTemplateCode: Code[10]; SynchOnlyCoupledRecords: Boolean)
    begin
        IntegrationTableMapping.CreateRecord(MappingName, TableNo, IntegrationTableNo, IntegrationTableUIDFieldNo, IntegrationTableModifiedFieldNo, TableConfigTemplateCode, IntegrationTableConfigTemplateCode, SynchOnlyCoupledRecords, IntegrationTableMapping.Direction::Bidirectional, 'Dataverse');
    end;
}