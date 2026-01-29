using { anubhav.db } from '../db/datamodel';

service CatalogService @(path: 'CatalogService') {

    // @readonly
    entity EmployeeSrv as projection on db.master.employees;
    //Other entities
    entity BusinessPartnerSet as projection on db.master.businesspartner;
    entity AddressSet as projection on db.master.address;
    entity ProductSet as projection on db.master.product;
    entity POItems as projection on db.transaction.poitems;

    function getLargestPurcaseOrder() returns PurchaseOrderSet;
    @(odata.draft.enabled:true, Common.DefaultValuesFunction:'getOrderStatus')
    entity PurchaseOrderSet as projection on db.transaction.purchaseorder {
        *,
        case OVERALL_STATUS 
            when 'P' then 'Pending'
            when 'A' then 'Approved'
            when 'X' then  'Rejected'
            when 'N' then 'New'
            end as OverallStatus : String(64),
        case OVERALL_STATUS 
            when 'P' then 2
            when 'A' then 3
            when 'X' then 1
            when 'N' then 2
            end as IconColor: Int16
    }
    actions {
        action boost() returns PurchaseOrderSet
    };

    function getOrderStatus() returns PurchaseOrderSet;
    
}