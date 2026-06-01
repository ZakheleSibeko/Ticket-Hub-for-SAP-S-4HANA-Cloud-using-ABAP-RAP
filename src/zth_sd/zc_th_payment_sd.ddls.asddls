@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Payment CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_TH_PAYMENT_SD 
 provider contract transactional_query
 as projection on ZI_TH_PAYMENT_SD
{
    key PaymentId,
    BookingId,
    PaymentDate,
    PaymentMethod,
    PaymentStatus,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    Amount,
    CurrencyCode,
    TransactionRef,
    /* Associations */
    _Booking
}
