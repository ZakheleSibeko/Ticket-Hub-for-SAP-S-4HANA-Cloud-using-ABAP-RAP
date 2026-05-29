@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Service item CDS view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TH_SERVICE_ITEM as select from zth_service_item
association to ZI_TH_VENDOR as _Vendor
 on $projection.VendorId = _Vendor.VendorId
{
    key service_id as ServiceId,
    service_name as ServiceName,
    service_category as ServiceCategory,
    description as Description,
    vendor_id as VendorId,
    unit_of_meaure as UnitOfMeaure,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    unit_price as UnitPrice,
    currency_code as CurrencyCode,
    tax_code as TaxCode,
    status as Status,
    valid_from as ValidFrom,
    valid_to as ValidTo,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    _Vendor
}
