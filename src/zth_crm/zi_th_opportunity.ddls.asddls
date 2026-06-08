@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Oppurtunity CDS view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TH_OPPORTUNITY as select from zth_opportunity
 association [0..1] to ZI_TH_I_BusinessPartner as _BusinessPartner
  on $projection.BpId = _BusinessPartner.BpId
{
    key opportunity_id as OpportunityId,
    bp_id as BpId,
    event_id as EventId,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    expected_revenue as ExpectedRevenue,
    currency_code as CurrencyCode,
    stage as Stage,
    status as Status,
    _BusinessPartner // Make association public
}
