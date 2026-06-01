@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vendor CDS view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TH_VENDOR 
as select from zth_vendor
{
    key vendor_id as VendorId,
    vendor_name as VendorName,
    vendor_type as VendorType,
    email as Email,
    phone as Phone,
    status as Status,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    local_lastchanged_by as LocalLastChangedBy,
    local_lastchanged_at as LocalLastChangedAt
}
