@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_TH_CUSTOMER_SD 
 provider contract transactional_query
 as projection on ZI_TH_CUSTOMER_SD
{
    key CustomerId,
    FirstName,
    LastName,
    Email,
    Phone,
    City,
    Country,
    Status,
    CreatedBy,
    CreatedAt,
    LocalLastchangedBy,
    LocalLastchangedAt
}
