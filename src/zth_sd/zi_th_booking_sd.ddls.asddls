@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking database table'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TH_BOOKING_SD as select from zth_booking_sd
composition [0..*] of ZI_TH_BOOKING_ITSD as _BookingItem
{
    key booking_id as BookingId,
    customer_id as CustomerId,
    event_id as EventId,
    booking_date as BookingDate,
    status as Status,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    total_amount as TotalAmount,
    currency_code as CurrencyCode,
    created_by as CreatedBy,
    created_at as CreatedAt,
    local_lastchanged_by as LocalLastchangedBy,
    local_lastchanged_at as LocalLastchangedAt,
    _BookingItem
}
