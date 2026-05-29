@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Settlement CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_TH_SETTLEMENT 
provider contract transactional_query
as projection on ZI_TH_SETTLEMENT
{
    key SettlementId,
    EventId,
    GrossRevenue,
    RefundAmount,
    TotalCost,
    PlatformCommission,
    NetSettlement,
    Status,
    CreatedBy,
    CreatedAt,
    LocalLastchangedBy,
    LocalLastchangedAt,
    /* Associations */
    _Refund
}
