@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_TH_BOOKING_SD 
 provider contract transactional_query
 as projection on ZI_TH_BOOKING_SD
{
    key BookingId,
    CustomerId,
    EventId,
    BookingDate,
    Status,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    TotalAmount,
    CurrencyCode,
    CreatedBy,
    CreatedAt,
    LocalLastchangedBy,
    LocalLastchangedAt,
    /* Associations */
    _BookingItem
}
