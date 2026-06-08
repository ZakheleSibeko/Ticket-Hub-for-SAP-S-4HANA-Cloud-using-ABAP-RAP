@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'One order pricing CDS view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_TH_ONEORDER_PRICING 
 as select from zth_oneorder_pri
 association to parent ZI_TH_ONEORDER_HDR as _Header
  on $projection.HeaderId = _Header.Guid
{
    key pricing_guid as PricingGuid,
    header_id as HeaderId,
    condition_type as ConditionType,
    value as Value,
    _Header
}
