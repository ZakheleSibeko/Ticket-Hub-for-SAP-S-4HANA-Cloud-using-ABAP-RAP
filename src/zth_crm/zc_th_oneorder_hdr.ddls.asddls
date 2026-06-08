@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'One order header CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
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
    _Appoitment,
    _Item,
    _Partner,
    _Pricing,
    _Status,
    _Text
}
