@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase req CDS view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TH_PURCHASE_REQ 
 as select from zth_purchase_req
 composition [0..* ] of ZI_TH_PUR_REQ_ITEM as _item
{
    key pr_id as PrId,
    event_id as EventId,
    status as Status,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    total_amount as TotalAmount,
    currency_code as CurrencyCode,
    requested_by as RequestedBy,
    request_date as RequestDate,
    last_changed_at as LastChangedAt,
    _item
}
