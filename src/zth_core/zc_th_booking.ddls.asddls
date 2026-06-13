@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ticket Booking projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_TH_BOOKING 
  as projection on ZI_TH_BOOKING
{
    @EndUserText.label: 'BookingId'
    key BookingId,
    @EndUserText.label: 'EventId'
    EventId,
    @EndUserText.label: 'CustomerId'
    CustomerId,
    @EndUserText.label: 'BookingDate'
    BookingDate,
    @EndUserText.label: 'Status'
    Status,
    @EndUserText.label: 'PaymentStatus'
    PaymentStatus,
    @EndUserText.label: 'GrossAmount'
    GrossAmount,
    @EndUserText.label: 'DiscountAmount'
    DiscountAmount,
    @EndUserText.label: 'TaxAmount'
    TaxAmount,
    @EndUserText.label: 'NetAmount'
    NetAmount,
    @EndUserText.label: 'CurrencyCode'
    CurrencyCode,
    @EndUserText.label: 'CreatedBy'
    CreatedBy,
    @EndUserText.label: 'CreatedAt'
    CreatedAt,
    @EndUserText.label: 'LastChangedBy'
    LastChangedBy,
    @EndUserText.label: 'LastChangedAt'
    LastChangedAt,
    /* Associations */
    _Event : redirected to parent ZC_TH_EVENT
//    _Booking_item : redirected to composition child ZC_TH_BOOKING_ITEM

}
