@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Business partner CDS view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TH_I_BusinessPartner 
 as select from zth_bp

{
    key bp_id as BpId,
    bp_type as BpType,
    first_name as FirstName,
    last_name as LastName,
    @Semantics.eMail.address: true
    email as Email,
    phone as Phone,
    status as Status,
    @Semantics.user.createdBy: true
    created_by as CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    created_at as CreatedAt,
    @Semantics.user.lastChangedBy: true
    last_changed_by as LastChangedBy,
    @Semantics.systemDateTime.lastChangedAt: true
    last_changed_at as LastChangedAt,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    local_last_changed_at as LocalLastChangedAt

}
