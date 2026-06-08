@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'One order text CDS view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_TH_ONEORDER_TEXT as select from zth_oneorder_txt
association to parent ZI_TH_ONEORDER_HDR as _Header
 on $projection.HeaderGuid = _Header.Guid
{
    key text_guid as TextGuid,
    header_guid as HeaderGuid,
    text_type as TextType,
    text_line as TextLine,
    _Header
}
