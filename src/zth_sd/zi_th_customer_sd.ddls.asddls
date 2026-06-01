@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer CDS view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TH_CUSTOMER_SD as select from zth_customer_sd
{
    key customer_id as CustomerId,
    first_name as FirstName,
    last_name as LastName,
    email as Email,
    phone as Phone,
    city as City,
    country as Country,
    status as Status,
    created_by as CreatedBy,
    created_at as CreatedAt,
    local_lastchanged_by as LocalLastchangedBy,
    local_lastchanged_at as LocalLastchangedAt

}
