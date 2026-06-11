@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'One order header CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_TH_ONEORDER_HDR
 provider contract transactional_query
 as projection on ZI_TH_ONEORDER_HDR
{
    key Guid,
    ProcessType,
    Description,
    Status,
    CreatedBy,
    CreatedAt,
    /* Associations */
    _Appointment : redirected to composition child ZC_TH_ONEORDER_APPT,
    _Item : redirected to composition child ZC_TH_ONEORDER_ITEM,
    _Partner : redirected to composition child ZC_TH_ONEORDER_PARTNER,
    _Pricing : redirected to composition child ZC_TH_ONEORDER_PRICING,
    _Status : redirected to composition child ZC_TH_ONEORDER_STATUS,
    _Text : redirected to composition child ZC_TH_ONEORDER_TEXT
}
