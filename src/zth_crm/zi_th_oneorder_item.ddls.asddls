@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'One order item CDS view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_TH_ONEORDER_ITEM as select from zth_oneorder_ite
association to parent ZI_TH_ONEORDER_HDR as _Header
    on $projection.HeaderGuid = _Header.Guid
{
    key item_guid as ItemGuid,
    header_guid as HeaderGuid,
    item_type as ItemType,
    product_id as ProductId,
    quantity as Quantity,
    _Header 
}
