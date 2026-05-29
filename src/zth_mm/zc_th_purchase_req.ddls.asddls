@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase req CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_TH_PURCHASE_REQ 
 provider contract transactional_query
 as projection on ZI_TH_PURCHASE_REQ
{
    key PrId,
    EventId,
    Status,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    TotalAmount,
    CurrencyCode,
    RequestedBy,
    RequestDate,
    LastChangedAt,
    /* Associations */
    _item
}
