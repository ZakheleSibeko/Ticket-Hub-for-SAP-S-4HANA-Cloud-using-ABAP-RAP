@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ticket Hub payment projection'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_TH_PAYMENT 
  provider contract transactional_query
  as projection on ZI_TH_PAYMENT
{
    key PaymentId,
    BookingId,
    CustomerId,
    PaymentDate,
    PaymentMethod,
    PaymentStatus,
    Amount,
    CurrencyCode,
    ReferenceNo,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    /* Associations */
    _Booking,
    _Customer
}
