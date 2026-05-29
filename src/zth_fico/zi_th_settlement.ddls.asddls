@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Settlement CDS view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TH_SETTLEMENT
  as select from zth_settlement
  association [0..*] to ZI_TH_REFUND as _Refund on $projection.RefundAmount = _Refund.RefundAmount
{
  key settlement_id        as SettlementId,
      event_id             as EventId,
      gross_revenue        as GrossRevenue,
      refund_amount        as RefundAmount,
      total_cost           as TotalCost,
      platform_commission  as PlatformCommission,
      net_settlement       as NetSettlement,
      status               as Status,
      created_by           as CreatedBy,
      created_at           as CreatedAt,
      local_lastchanged_by as LocalLastchangedBy,
      local_lastchanged_at as LocalLastchangedAt,
      _Refund
}
