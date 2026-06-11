@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Item CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_TH_ONEORDER_ITEM as projection on ZI_TH_ONEORDER_ITEM
{
    key ItemGuid,
    HeaderGuid,
    ItemType,
    ProductId,
    Quantity,
    /* Associations */
    _Header : redirected to parent ZC_TH_ONEORDER_HDR
}
