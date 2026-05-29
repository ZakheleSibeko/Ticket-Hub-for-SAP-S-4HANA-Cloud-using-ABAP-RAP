@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase order CDS view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TH_PURCH_ORDER as select from zth_purch_order
association [1] to ZI_TH_VENDOR as _Vendor
 on $projection.EventId = _Vendor.VendorId
{
    key po_id as PoId,
    pr_id as PrId,
    event_id as EventId,
    vendor_id as VendorId,
    po_number as PoNumber,
    po_date as PoDate,
    status as Status,
    approval_status as ApprovalStatus,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    total_amount as TotalAmount,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    tax_amount as TaxAmount,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    net_amount as NetAmount,
    currency_code as CurrencyCode,
    delivery_date as DeliveryDate,
    payment_terms as PaymentTerms,
    created_by as CreatedBy,
    created_at as CreatedAt,
    approved_by as ApprovedBy,
    approved_at as ApprovedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    _Vendor
}
