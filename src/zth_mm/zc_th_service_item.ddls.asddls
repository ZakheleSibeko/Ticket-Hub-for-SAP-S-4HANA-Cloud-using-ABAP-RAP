@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Service item CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_TH_SERVICE_ITEM 
 provider contract transactional_query
 as projection on ZI_TH_SERVICE_ITEM
{
    key ServiceId,
    ServiceName,
    ServiceCategory,
    Description,
    VendorId,
    UnitOfMeaure,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    UnitPrice,
    CurrencyCode,
    TaxCode,
    Status,
    ValidFrom,
    ValidTo,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    /* Associations */
    _Vendor
}
