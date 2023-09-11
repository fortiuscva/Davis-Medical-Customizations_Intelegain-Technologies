/// <summary>
/// Table Sales History (ID 50130).
/// </summary>
table 50130 "Davis customer history"
{
    Caption = 'Davis Customer History';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = Invoice,"Credit Memo";
            DataClassification = ToBeClassified;
        }
        field(2; "Invoice No."; Code[50])
        {
            Caption = 'Invoice No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Customer No."; Code[50])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = "Customer"."No.";
            trigger OnValidate()
            var
                customer: Record Customer;
            begin
                if customer.get(rec."Customer No.") then Rec."Account Name" := customer.Name;
            end;
        }
        field(4; "Account Name"; Text[250])
        {
            Caption = 'Account Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Item No."; Code[50])
        {
            Caption = 'Item No.';
            TableRelation = Item."No.";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                item: Record Item;
            begin
                If item.get("Item No.") then begin
                    rec.UOM := item."Base Unit of Measure";
                    rec."Item Name " := item.Description;
                end;
            end;
        }
        field(6; "Item Name "; Text[250])
        {
            Caption = 'Item Name ';
            DataClassification = ToBeClassified;
        }
        field(7; Qty; Decimal)
        {
            Caption = 'Qty';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if rec.Qty <> 0 then begin
                    rec.Amount := rec.Qty * rec."Unit Price";
                end;
            end;
        }
        field(8; UOM; Text[100])
        {
            Caption = 'UOM';
            DataClassification = ToBeClassified;
        }
        field(9; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if rec.Qty <> 0 then begin
                    rec.Amount := rec.Qty * rec."Unit Price";
                end;
            end;
        }
        field(10; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(11; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
    }
    keys
    {
        key(PK; "Document Type", "Invoice No.", "Customer No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        Customer: Record Customer;
        Item: Record Item;
    begin
        if rec."Document Type" = rec."Document Type"::Invoice then
            if Customer.get("Customer No.") then
                rec."Account Name" := Customer.Name;
        If item.get("Item No.") then begin
            rec.UOM := item."Base Unit of Measure";
            rec."Item Name " := item.Description;
        end;

    end;
}
