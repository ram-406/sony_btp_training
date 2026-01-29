using CatalogService as service from '../../srv/CatalogService';

annotate service.PurchaseOrderSet with @(
    UI.SelectionFields    : [
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        GROSS_AMOUNT,
        OVERALL_STATUS
    ],
    UI.LineItem           : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID,
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Boost',
            Action: 'CatalogService.boost',
            Inline: true
        },
        {
            $Type      : 'UI.DataField',
            Value      : OverallStatus,
            Criticality: IconColor
        },
    ],
    UI.HeaderInfo         : {
        TypeName      : 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        Title         : {Value: PO_ID},
        Description   : {Value: PARTNER_GUID.COMPANY_NAME},
    },

    UI.Facets             : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Additinal Info',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'More Info',
                    Target: '@UI.Identification'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Pricing Info',
                    Target: '@UI.FieldGroup#pricing'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Status',
                    Target: '@UI.FieldGroup#status'
                }
            ]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Items',
            Target: 'Items/@UI.LineItem',
        },
    ],
    UI.Identification     : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID
        },
        {
            $Type: 'UI.DataField',
            Value: NOTE
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID_NODE_KEY
        },
    ],

    UI.FieldGroup #pricing: {Data: [
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT
        },
    ]},
    UI.FieldGroup #status : {Data: [
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code,
        },
        {
            $Type: 'UI.DataField',
            Value: OVERALL_STATUS,
        },
        {
            $Type: 'UI.DataField',
            Value: LIFECYCLE_STATUS,
        }
    ]}
);

annotate service.POItems with @(
    UI.LineItem      : [
        {
            $Type: 'UI.DataField',
            Value: PO_ITEM_POS,
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT,
        },
    ],
    UI.HeaderInfo    : {
        TypeName      : 'PO Item',
        TypeNamePlural: 'Purchase Order Items',
        Title         : {Value: PO_ITEM_POS},
        Description   : {Value: PRODUCT_GUID.DESCRIPTION}
    },
    UI.Facets        : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'Item Details',
        Target: '@UI.Identification',
    }, ],
    UI.Identification: [
        {
            $Type: 'UI.DataField',
            Value: PO_ITEM_POS,
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code,
        },
    ]
);


annotate service.PurchaseOrderSet with {
    @Common: {
        FilterDefaultValue: 'P',
        Text              : OverallStatus,
    }
    OVERALL_STATUS;
    @Common: {
        Text            : PARTNER_GUID.COMPANY_NAME,
        ValueList.entity: service.BusinessPartnerSet
    }
    PARTNER_GUID;

};

annotate service.POItems with {
    @Common: {
        FilterDefaultValue: 'P',
        Text              : PRODUCT_GUID.DESCRIPTION,
        ValueList.entity  : service.ProductSet
    }
    PRODUCT_GUID;
};
@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(UI.Identification: [{
    $Type: UI.DataField,
    Value: COMPANY_NAME,
}]);

@cds.odata.valuelist
annotate service.ProductSet with @(UI.Identification: [{
    $Type: UI.DataField,
    Value: DESCRIPTION,
}]);
