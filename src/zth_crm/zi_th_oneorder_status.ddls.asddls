@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'One order status CDS view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_TH_ONEORDER_STATUS as select from zth_oneorder_sta
association to parent ZI_TH_ONEORDER_HDR as _Header
    on $projection.HeaderGuid = _Header.Guid
{
    key status_guid as StatusGuid,
    header_guid as HeaderGuid,
    status as Status,
    active as Active,
    _Header // Make association public
}
