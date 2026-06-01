@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Payment database table'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TH_PAYMENT_SD as select from zth_payment_sd
association to ZI_TH_BOOKING_SD as _Booking
  on $projection.BookingId = _Booking.BookingId
{
    key payment_id as PaymentId,
    booking_id as BookingId,
    payment_date as PaymentDate,
    payment_method as PaymentMethod,
    payment_status as PaymentStatus,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    amount as Amount,
    currency_code as CurrencyCode,
    transaction_ref as TransactionRef,
    _Booking
}
