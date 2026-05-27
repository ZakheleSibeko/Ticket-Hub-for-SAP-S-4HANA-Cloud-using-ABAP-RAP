@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ticket Hub customer projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_TH_CUSTOMER 
  provider contract transactional_query
  as projection on ZI_TH_CUSTOMER
{
    key CustomerId,
    FirstName,
    LastName,
    Email,
    PhoneNumber,
    City,
    CountryCode,
    DateOfBirth,
    Newsletter,
    Status,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _Booking
}
