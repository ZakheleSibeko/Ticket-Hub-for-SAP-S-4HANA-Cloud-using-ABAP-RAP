@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Partner CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_TH_ONEORDER_PARTNER 
 as projection on ZI_TH_ONEORDER_PARTNER
{
    key PartnerGuid,
    HeaderGuid,
    BpId,
    PartnerFunction,
    /* Associations */
    _Header : redirected to parent ZC_TH_ONEORDER_HDR
}
