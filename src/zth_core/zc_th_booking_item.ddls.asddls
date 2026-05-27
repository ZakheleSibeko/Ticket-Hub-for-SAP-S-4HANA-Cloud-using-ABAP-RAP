@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ticket Hub booking item projection'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_TH_BOOKING_ITEM
 as projection on ZI_TH_BOOKING_ITEM
{
    key BookingItemId,
    BookingId,
    EventId,
    TicketTypeId,
    Quantity,
    UnitPrice,
    GrossAmount,
    DiscountAmount,
    NetAmount,
    CurrencyCode,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    /* Associations */
    _Event : redirected to parent ZC_TH_EVENT
//    _Event : redirected to parent ZC_TH_EVENT
}
