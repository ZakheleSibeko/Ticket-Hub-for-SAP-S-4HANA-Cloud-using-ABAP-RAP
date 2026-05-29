@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Supplier invoice CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_TH_SUPP_INVOICE 
 provider contract transactional_query
 as projection on ZI_TH_SUPP_INVOICE
{
    key InvoiceId,
    PoId,
    VendorId,
    InvoiceDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    Amount,
    CurrencyCode,
    Status,
    /* Associations */
    _PurchaseOrder
}
