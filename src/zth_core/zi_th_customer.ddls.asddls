@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ticket Hub customer'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TH_CUSTOMER
  as select from zth_customer
  association [0..*] to ZI_TH_BOOKING as _Booking on $projection.CustomerId = _Booking.CustomerId
{
  key customer_id           as CustomerId,
      first_name            as FirstName,
      last_name             as LastName,
      email                 as Email,
      phone_number          as PhoneNumber,
      city                  as City,
      country_code          as CountryCode,
      date_of_birth         as DateOfBirth,
      newsletter            as Newsletter,
      status                as Status,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      last_changed_by       as LastChangedBy,
      last_changed_at       as LastChangedAt,
      local_last_changed_at as LocalLastChangedAt,
      _Booking
}
