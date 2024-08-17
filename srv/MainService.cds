using { nidhisha.db.master, nidhisha.db.transaction } from '../db/nidhdatamodel';
using { cappo.cds } from '../db/nidhCDSView';


service MainService @(path: 'MainService')
{
    
    entity EmployeeSet as projection on master.employees;
    entity BusinessPartnerSet as projection on master.businesspartner;
    entity BusinessAddressSet as projection on master.address;
    entity ProductSet as projection on master.product;
    //@Capabilities:{Deletable:false}
    entity POs @(odata.draft.enabled:true) as projection on transaction.purchaseorder{
        *,
        Items,
        case OVERALL_STATUS
            when 'P' then 'Pending'
            when 'N' then 'New'
            when 'A' then 'Approved'
            when 'X' then 'Rejected'
            end as OverallStatus: String(15),
        case OVERALL_STATUS
            when 'P' then 2
            when 'N' then 2
            when 'A' then 3
            when 'X' then 1
            end as ColorCode: Integer,

    }
    
    actions{
        @Common.SideEffects : {
            $Type : 'Common.SideEffectsType',
            TargetProperties:[
                'in/GROSS_AMOUNT'
            ]
        }
        action boost() returns POs
    }

    function getLargestOrder() returns array of POs;
    function getStatusDefault() returns POs;
    

    
    entity POItems as projection on transaction.poitems;

    // entity OrderItems@cds.redirection.target as projection on cds.CDSViews.ProductView;
     //entity Products as projection on cds.CDSViews.ProductView;
}