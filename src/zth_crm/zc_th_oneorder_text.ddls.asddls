@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Text CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_TH_ONEORDER_TEXT 
 as projection on ZI_TH_ONEORDER_TEXT
{
    key TextGuid,
    HeaderGuid,
    TextType,
    TextLine,
    /* Associations */
    _Header : redirected to parent ZC_TH_ONEORDER_HDR
}
