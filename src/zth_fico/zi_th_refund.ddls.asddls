@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Refund CDS view'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZI_TH_REFUND
  as select from zth_refund
  association to ZI_TH_BOOKING as _Booking 
   on $projection.BookingId = _Booking.BookingId
{
  key refund_id            as RefundId,
      booking_id           as BookingId,
      customer_id          as CustomerId,
      refund_date          as RefundDate,
      refund_amount        as RefundAmount,
      refund_reason        as RefundReason,
      status               as Status,
      currency_code        as CurrencyCode,
      approved_by          as ApprovedBy,
      approved_at          as ApprovedAt,
      created_by           as CreatedBy,
      created_at           as CreatedAt,
      local_lastchanged_by as LocalLastchangedBy,
      local_lastchanged_at as LocalLastchangedAt,
      _Booking
}
