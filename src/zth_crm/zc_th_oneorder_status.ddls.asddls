@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Status CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_TH_ONEORDER_STATUS as projection on ZI_TH_ONEORDER_STATUS
{
    key StatusGuid,
    HeaderGuid,
    Status,
    Active,
    /* Associations */
    _Header : redirected to parent ZC_TH_ONEORDER_HDR
}
