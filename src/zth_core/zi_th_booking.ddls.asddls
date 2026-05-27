@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ticket Booking'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_TH_BOOKING
  as select from zth_booking
  association to parent ZI_TH_EVENT    as _Event 
  on $projection.EventId = _Event.EventId
  association [0..*] to ZI_TH_BOOKING_ITEM as _Booking_item
    on $projection.BookingId = _Booking_item.BookingId
  association [1] to ZI_TH_CUSTOMER        as _Customer  on $projection.CustomerId = _Customer.CustomerId

{
  key booking_id      as BookingId,
      event_id        as EventId,
      customer_id     as CustomerId,
      booking_date    as BookingDate,
      status          as Status,
      payment_status  as PaymentStatus,
      gross_amount    as GrossAmount,
      discount_amount as DiscountAmount,
      tax_amount      as TaxAmount,
      net_amount      as NetAmount,
      currency_code   as CurrencyCode,
      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_by as LastChangedBy,
      last_changed_at as LastChangedAt,
      _Event,
      _Booking_item,
      _Customer
}
