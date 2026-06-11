@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Appointment CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_TH_ONEORDER_APPT 
 as projection on ZI_TH_ONEORDER_APPT
{
    key ApptGuid,
    HeaderGuid,
    ApptType,
    StartDate,
    EndDate,
    /* Associations */
    _Header : redirected to parent ZC_TH_ONEORDER_HDR
}
