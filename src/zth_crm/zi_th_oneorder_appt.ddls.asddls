@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'One order appointment CDS view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_TH_ONEORDER_APPT 
 as select from zth_oneorder_apt
 association to parent ZI_TH_ONEORDER_HDR as _Header
  on $projection.HeaderGuid = _Header.Guid
{
    key appt_guid as ApptGuid,
    header_guid as HeaderGuid,
    appt_type as ApptType,
    start_date as StartDate,
    end_date as EndDate,
     _Header
}
