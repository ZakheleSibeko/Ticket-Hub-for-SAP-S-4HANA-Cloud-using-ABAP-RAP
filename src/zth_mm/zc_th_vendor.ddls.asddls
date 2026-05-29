@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vendor CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_TH_VENDOR
provider contract transactional_query 
as projection on ZI_TH_VENDOR
{
    key VendorId,
    VendorName,
    VendorType,
    Email,
    Phone,
    Status,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt
}
