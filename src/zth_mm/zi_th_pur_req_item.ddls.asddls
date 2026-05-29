@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase req item CDS view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_TH_PUR_REQ_ITEM
  as select from zth_pur_req_item
  association     to parent ZI_TH_PURCHASE_REQ as _PurchaseReq on $projection.PrId = _PurchaseReq.PrId

  association [1] to ZI_TH_SERVICE_ITEM        as _Service     on $projection.ServiceId = _Service.ServiceId
{
  key pr_item_id    as PrItemId,
      pr_id         as PrId,
      service_id    as ServiceId,
      quantity      as Quantity,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      unit_price    as UnitPrice,
      currency_code as CurrencyCode,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      net_amount    as NetAmount,
      _PurchaseReq,
      _Service
}
