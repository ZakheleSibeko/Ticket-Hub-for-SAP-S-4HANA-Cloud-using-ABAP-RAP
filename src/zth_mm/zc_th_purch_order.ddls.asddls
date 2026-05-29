@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase order CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_TH_PURCH_ORDER
  provider contract transactional_query 
  as projection on ZI_TH_PURCH_ORDER
{
    key PoId,
    PrId,
    EventId,
    VendorId,
    PoNumber,
    PoDate,
    Status,
    ApprovalStatus,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    TotalAmount,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    TaxAmount,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    NetAmount,
    CurrencyCode,
    DeliveryDate,
    PaymentTerms,
    CreatedBy,
    CreatedAt,
    ApprovedBy,
    ApprovedAt,
    LastChangedBy,
    LastChangedAt,
    /* Associations */
    _Vendor
}
