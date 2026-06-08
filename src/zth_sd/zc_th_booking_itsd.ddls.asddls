@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking item CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_TH_BOOKING_ITSD 
  as projection on ZI_TH_BOOKING_ITSD
{
    key BookingItemId,
    BookingId,
    TicketTypeId,
    Quantity,
    UnitPrice,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    NetAmount,
    CurrencyCode,
    /* Associations */
    _Booking : redirected to parent ZC_TH_BOOKING_SD
}
