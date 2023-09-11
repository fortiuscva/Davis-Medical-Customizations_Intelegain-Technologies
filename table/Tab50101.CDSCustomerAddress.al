/// <summary>
/// Table CDS CustomerAddress (ID 50101).
/// </summary>
table 50101 "CDS CustomerAddress"
{
    //new customeraddress
    ExternalName = 'customeraddress';
    TableType = CRM;
    Description = 'Address and shipping information. Used to store additional addresses for an account or contact.';

    fields
    {
        field(1; ParentId; GUID)
        {
            ExternalName = 'parentid';
            ExternalType = 'Lookup';
            Description = 'Choose the customer''s address.';
            Caption = 'Parent';
        }
        field(2; CustomerAddressId; GUID)
        {
            ExternalName = 'customeraddressid';
            ExternalType = 'Uniqueidentifier';
            ExternalAccess = Insert;
            Description = 'Unique identifier of the customer address.';
            Caption = 'Address';
        }
        field(3; AddressNumber; Integer)
        {
            ExternalName = 'addressnumber';
            ExternalType = 'Integer';
            Description = 'Shows the number of the address, to indicate whether the address is the primary, secondary, or other address for the customer.';
            Caption = 'Address Number';
        }
        field(5; AddressTypeCode; Option)
        {
            ExternalName = 'addresstypecode';
            ExternalType = 'Picklist';
            Description = 'Select the address type, such as primary or billing.';
            Caption = 'Address Type';
            InitValue = " ";
            OptionMembers = " ",BillTo,ShipTo,Primary,Other;
            OptionOrdinalValues = -1, 1, 2, 3, 4;
        }
        field(6; Name; Text[200])
        {
            ExternalName = 'name';
            ExternalType = 'String';
            Description = 'Type a descriptive name for the customer''s address, such as Corporate Headquarters.';
            Caption = 'Address Name';
        }
        field(7; PrimaryContactName; Text[150])
        {
            ExternalName = 'primarycontactname';
            ExternalType = 'String';
            Description = 'Type the name of the primary contact person for the customer''s address.';
            Caption = 'Address Contact';
        }
        field(8; Line1; Text[250])
        {
            ExternalName = 'line1';
            ExternalType = 'String';
            Description = 'Type the first line of the customer''s address to help identify the location.';
            Caption = 'Street 1';
        }
        field(9; Line2; Text[250])
        {
            ExternalName = 'line2';
            ExternalType = 'String';
            Description = 'Type the second line of the customer''s address.';
            Caption = 'Street 2';
        }
        field(10; Line3; Text[250])
        {
            ExternalName = 'line3';
            ExternalType = 'String';
            Description = 'Type the third line of the customer''s address.';
            Caption = 'Street 3';
        }
        field(11; City; Text[80])
        {
            ExternalName = 'city';
            ExternalType = 'String';
            Description = 'Type the city for the customer''s address to help identify the location.';
            Caption = 'City';
        }
        field(12; StateOrProvince; Text[50])
        {
            ExternalName = 'stateorprovince';
            ExternalType = 'String';
            Description = 'Type the state or province of the customer''s address.';
            Caption = 'State/Province';
        }
        field(13; County; Text[50])
        {
            ExternalName = 'county';
            ExternalType = 'String';
            Description = 'Type the county for the customer''s address.';
            Caption = 'County';
        }
        field(14; Country; Text[80])
        {
            ExternalName = 'country';
            ExternalType = 'String';
            Description = 'Type the country or region for the customer''s address.';
            Caption = 'Country/Region';
        }
        field(15; PostOfficeBox; Text[20])
        {
            ExternalName = 'postofficebox';
            ExternalType = 'String';
            Description = 'Type the post office box number of the customer''s address.';
            Caption = 'Post Office Box';
        }
        field(16; PostalCode; Text[20])
        {
            ExternalName = 'postalcode';
            ExternalType = 'String';
            Description = 'Type the ZIP Code or postal code for the address.';
            Caption = 'ZIP/Postal Code';
        }
        field(17; UTCOffset; Integer)
        {
            ExternalName = 'utcoffset';
            ExternalType = 'Integer';
            Description = 'Select the time zone for the address.';
            Caption = 'UTC Offset';
        }
        field(18; FreightTermsCode; Option)
        {
            ExternalName = 'freighttermscode';
            ExternalType = 'Picklist';
            Description = 'Select the freight terms to make sure shipping charges are processed correctly.';
            Caption = 'Freight Terms';
            InitValue = " ";
            OptionMembers = " ",FOB,NoCharge;
            OptionOrdinalValues = -1, 1, 2;
        }
        field(19; UPSZone; Text[4])
        {
            ExternalName = 'upszone';
            ExternalType = 'String';
            Description = 'Type the UPS zone of the customer''s address to make sure shipping charges are calculated correctly and deliveries are made promptly, if shipped by UPS.';
            Caption = 'UPS Zone';
        }
        field(20; Latitude; Decimal)
        {
            ExternalName = 'latitude';
            ExternalType = 'Double';
            Description = 'Type the latitude value for the customer''s address, for use in mapping and other applications.';
            Caption = 'Latitude';
        }
        field(21; Telephone1; Text[50])
        {
            ExternalName = 'telephone1';
            ExternalType = 'String';
            Description = 'Type the primary phone number for the customer''s address.';
            Caption = 'Main Phone';
        }
        field(22; Longitude; Decimal)
        {
            ExternalName = 'longitude';
            ExternalType = 'Double';
            Description = 'Type the longitude value for the customer''s address, for use in mapping and other applications.';
            Caption = 'Longitude';
        }
        field(23; ShippingMethodCode; Option)
        {
            ExternalName = 'shippingmethodcode';
            ExternalType = 'Picklist';
            Description = 'Select a shipping method for deliveries sent to this address.';
            Caption = 'Shipping Method';
            InitValue = " ";
            OptionMembers = " ",Bestway,CustomerAcct,DHLIntl,DropShip,ExpressIntl,FedExGround,FedExIntlEcon,FedExIntlPrior,FedExSaver,UPS3rdDay,UPSWWStandard,USPSPriorIntl,WillCall;
            OptionOrdinalValues = -1, 1, 166580000, 166580001, 166580002, 166580003, 166580004, 166580005, 166580006, 166580007, 166580008, 166580009, 166580010, 166580011;
        }
        field(24; Telephone2; Text[50])
        {
            ExternalName = 'telephone2';
            ExternalType = 'String';
            Description = 'Type a second phone number for the customer''s address.';
            Caption = 'Phone 2';
        }
        field(25; Telephone3; Text[50])
        {
            ExternalName = 'telephone3';
            ExternalType = 'String';
            Description = 'Type a third phone number for the customer''s address.';
            Caption = 'Telephone 3';
        }
        field(26; Fax; Text[50])
        {
            ExternalName = 'fax';
            ExternalType = 'String';
            Description = 'Type the fax number associated with the customer''s address.';
            Caption = 'Fax';
        }
        field(27; VersionNumber; BigInteger)
        {
            ExternalName = 'versionnumber';
            ExternalType = 'BigInt';
            ExternalAccess = Read;
            Description = 'Version number of the customer address.';
            Caption = 'Version Number';
        }
        field(29; CreatedOn; Datetime)
        {
            ExternalName = 'createdon';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Shows the date and time when the record was created. The date and time are displayed in the time zone selected in Microsoft Dynamics 365 options.';
            Caption = 'Created On';
        }
        field(31; ModifiedOn; Datetime)
        {
            ExternalName = 'modifiedon';
            ExternalType = 'DateTime';
            ExternalAccess = Read;
            Description = 'Shows the date and time when the record was last updated. The date and time are displayed in the time zone selected in Microsoft Dynamics 365 options.';
            Caption = 'Modified On';
        }
        field(43; TimeZoneRuleVersionNumber; Integer)
        {
            ExternalName = 'timezoneruleversionnumber';
            ExternalType = 'Integer';
            Description = 'For internal use only.';
            Caption = 'Time Zone Rule Version Number';
        }
        field(44; OverriddenCreatedOn; Date)
        {
            ExternalName = 'overriddencreatedon';
            ExternalType = 'DateTime';
            ExternalAccess = Insert;
            Description = 'Date and time that the record was migrated.';
            Caption = 'Record Created On';
        }
        field(45; UTCConversionTimeZoneCode; Integer)
        {
            ExternalName = 'utcconversiontimezonecode';
            ExternalType = 'Integer';
            Description = 'Time zone code that was in use when the record was created.';
            Caption = 'UTC Conversion Time Zone Code';
        }
        field(46; ImportSequenceNumber; Integer)
        {
            ExternalName = 'importsequencenumber';
            ExternalType = 'Integer';
            ExternalAccess = Insert;
            Description = 'Unique identifier of the data import or data migration that created this record.';
            Caption = 'Import Sequence Number';
        }
        field(62; ExchangeRate; Decimal)
        {
            ExternalName = 'exchangerate';
            ExternalType = 'Decimal';
            ExternalAccess = Read;
            Description = 'Shows the conversion rate of the record''s currency. The exchange rate is used to convert all money fields in the record from the local currency to the system''s default currency.';
            Caption = 'Exchange Rate';
        }
        field(63; Composite; BLOB)
        {
            ExternalName = 'composite';
            ExternalType = 'Memo';
            ExternalAccess = Read;
            Description = 'Shows the complete address.';
            Caption = 'Address';
            Subtype = Memo;
        }
        field(10001; ikl_LinkID; Text[100])
        {
            ExternalName = 'ikl_linkid';
            ExternalType = 'String';
            Description = 'to store link id';
            Caption = 'Link ID';
        }
    }
    keys
    {
        key(PK; CustomerAddressId)
        {
            Clustered = true;
        }
        key(Name; Name)
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Name)
        {
        }
    }
}