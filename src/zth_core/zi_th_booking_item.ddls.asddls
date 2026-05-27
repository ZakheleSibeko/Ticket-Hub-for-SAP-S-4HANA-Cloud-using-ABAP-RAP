@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ticket Hub booking item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_TH_BOOKING_ITEM
  as select from zth_booking_item
 association to parent ZI_TH_EVENT    as _Event 
  on $projection.EventId = _Event.EventId
  association to ZI_TH_BOOKING as _Booking 
   on $projection.BookingId = _Booking.BookingId
{
  key booking_item_id as BookingItemId,
      booking_id      as BookingId,
      event_id        as EventId,
      ticket_type_id  as TicketTypeId,
      quantity        as Quantity,
      unit_price      as UnitPrice,
      gross_amount    as GrossAmount,
      discount_amount as DiscountAmount,
      net_amount      as NetAmount,
      currency_code   as CurrencyCode,
      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_by as LastChangedBy,
      last_changed_at as LastChangedAt,
      _Booking,
      _Event
}
