@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Supplier invoice CDS invoice'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TH_SUPP_INVOICE as select from zth_supp_invoice
association [1] to ZI_TH_PURCH_ORDER as _PurchaseOrder
 on $projection.PoId = _PurchaseOrder.PoId
{
    key invoice_id as InvoiceId,
    po_id as PoId,
    vendor_id as VendorId,
    invoice_date as InvoiceDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    amount as Amount,
    currency_code as CurrencyCode,
    status as Status,
    _PurchaseOrder // Make association public
}
