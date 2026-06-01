@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking item database table'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_TH_BOOKING_ITSD as select from zth_booking_itsd
association to parent ZI_TH_BOOKING_SD as __Booking
    on $projection.BookingId = __Booking.BookingId
{
    key booking_item_id as BookingItemId,
    booking_id as BookingId,
    ticket_type_id as TicketTypeId,
    quantity as Quantity,
    unit_price as UnitPrice,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    net_amount as NetAmount,
    currency_code as CurrencyCode,
    __Booking 
}
