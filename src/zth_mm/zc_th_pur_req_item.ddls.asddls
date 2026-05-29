@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase req item CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_TH_PUR_REQ_ITEM 
 provider contract transactional_query
 as projection on ZI_TH_PUR_REQ_ITEM
{
    key PrItemId,
    PrId,
    ServiceId,
    Quantity,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    UnitPrice,
    CurrencyCode,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    NetAmount,
    /* Associations */
    _PurchaseReq,
    _Service
}
