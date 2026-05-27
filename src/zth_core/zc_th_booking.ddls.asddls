@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ticket Booking projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_TH_BOOKING 
  as projection on ZI_TH_BOOKING
{
    key BookingId,
    EventId,
    CustomerId,
    BookingDate,
    Status,
    PaymentStatus,
    GrossAmount,
    DiscountAmount,
    TaxAmount,
    NetAmount,
    CurrencyCode,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    /* Associations */
    _Event : redirected to parent ZC_TH_EVENT
//    _Booking_item : redirected to composition child ZC_TH_BOOKING_ITEM

}
