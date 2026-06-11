@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Pricing CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_TH_ONEORDER_PRICING 
 as projection on ZI_TH_ONEORDER_PRICING
{
    key PricingGuid,
    HeaderId,
    ConditionType,
    Value,
    /* Associations */
    _Header : redirected to parent ZC_TH_ONEORDER_HDR
}
