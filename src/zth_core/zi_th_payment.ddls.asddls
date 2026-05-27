@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ticket Hub payment'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TH_PAYMENT 
  as select from zth_payment
  association [1] to ZI_TH_BOOKING as _Booking
   on $projection.BookingId = _Booking.BookingId
   
  association [1] to ZI_TH_CUSTOMER as _Customer
   on $projection.CustomerId = _Customer.CustomerId 
{
    key payment_id as PaymentId,
    booking_id as BookingId,
    customer_id as CustomerId,
    payment_date as PaymentDate,
    payment_method as PaymentMethod,
    payment_status as PaymentStatus,
    amount as Amount,
    currency_code as CurrencyCode,
    reference_no as ReferenceNo,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    _Booking,
    _Customer
}
