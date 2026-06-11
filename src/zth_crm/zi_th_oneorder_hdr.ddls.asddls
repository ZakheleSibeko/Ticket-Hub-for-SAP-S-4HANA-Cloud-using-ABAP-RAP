@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'One order header CDS view'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZI_TH_ONEORDER_HDR 
 as select from zth_oneorder_hdr
 composition [0..*] of ZI_TH_ONEORDER_ITEM    as _Item
 composition [0..*] of ZI_TH_ONEORDER_PARTNER as _Partner
 composition [0..*] of ZI_TH_ONEORDER_STATUS  as _Status
 composition [0..*] of ZI_TH_ONEORDER_TEXT    as _Text
 composition [0..*] of ZI_TH_ONEORDER_PRICING as _Pricing
 composition [0..*] of ZI_TH_ONEORDER_APPT    as _Appointment
{
    key guid as Guid,
    process_type as ProcessType,
    description as Description,
    status as Status,
    created_by as CreatedBy,
    created_at as CreatedAt,
    _Item,
    _Partner,
    _Status,
    _Text, 
    _Pricing,
    _Appointment 
}
