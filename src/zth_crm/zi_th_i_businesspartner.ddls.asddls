@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Business partner CDS view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TH_I_BusinessPartner 
 as select from zth_bp

{
    key bp_id as BpId,
    bp_type as BpType,
    first_name as FirstName,
    last_name as LastName,
    email as Email,
    phone as Phone,
    status as Status,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    local_last_changed_at as LocalLastChangedAt

}
