using MainService as service from '../../srv/MainService';

annotate service.POs with @(
    Common.DefaultValuesFunction : 'getStatusDefault',
    UI.SelectionFields:[
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        GROSS_AMOUNT,
        OVERALL_STATUS
    ],
    UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME ,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'MainService.boost',
            Label : 'boost',
            Inline : true,
        },
        {
            $Type : 'UI.DataField',
            Value : OverallStatus,
            Criticality : ColorCode,
        },


    ],
    UI.HeaderInfo:{
        TypeName : 'Purchase Order',
        TypeNamePlural : 'Purchase Orders',
        Title : {Value: PO_ID},
        Description : {Value : PARTNER_GUID.COMPANY_NAME,},
    },
    UI.Facets:[
        {
            $Type : 'UI.CollectionFacet',
            Label : 'General Info',
            Facets:[
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Order Details',
                    Target : '@UI.Identification'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label: 'Pricing',
                    Target : '@UI.FieldGroup'
                }
              
            ]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label: 'PO Items',
            Target : 'Items/@UI.LineItem'
        }


    
    ],
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Value: PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value: PARTNER_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : OVERALL_STATUS,
        },

    ],
    UI.FieldGroup  : {
        // $Type : 'UI.FieldGroupType',
        Label : 'Pricing',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value: TAX_AMOUNT,
            },
        ],
        
    },

    
);

annotate service.POItems with @(
    UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        }
    ],
    UI.HeaderInfo:{
        TypeName : 'PO Item',
        TypeNamePlural : 'PO Items',
        Title : {Value : PO_ITEM_POS},
        Description : {Value : PRODUCT_GUID.DESCRIPTION },
    },
    UI.Facets:[
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Additional Info',
            Target : '@UI.Identification',
        },

    ],
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        }
    ]


    
);
// linking value help with annotate

annotate service.POs with{
    PARTNER_GUID @(
        Common : {
            Text : PARTNER_GUID.COMPANY_NAME
        },
        valuelist.entity: CatalogService.BusinessPartnerSet
        
    );
    OVERALL_STATUS @(
        readonly
    )
    
 } ;

annotate service.POItems with {
     PRODUCT_GUID@(
        Common : {
            Text : PRODUCT_GUID.DESCRIPTION
        },
        valuelist.entity: CatalogService.ProductSet
        
    );
}

// adding value help
@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : COMPANY_NAME,
    }]
);

@cds.odata.valuelist
annotate service.ProductSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : DESCRIPTION,
    }]
);





