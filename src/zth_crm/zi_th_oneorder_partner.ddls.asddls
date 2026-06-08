@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'One order partner CDS view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_TH_ONEORDER_PARTNER as select from zth_oneorder_par
association to parent ZI_TH_ONEORDER_HDR as _Header
    on $projection.HeaderGuid = _Header.Guid
{
    key partner_guid as PartnerGuid,
    header_guid as HeaderGuid,
    bp_id as BpId,
    partner_function as PartnerFunction,
    _Header // Make association public
}
