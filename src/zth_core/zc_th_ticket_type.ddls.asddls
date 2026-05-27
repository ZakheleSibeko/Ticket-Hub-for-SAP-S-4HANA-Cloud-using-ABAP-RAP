@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ticket type projection'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_TH_TICKET_TYPE
 as projection on ZI_TH_TICKET_TYPE
{
    key TicketTypeId,
    EventId,
    TicketTypeName,
    CurrencyCode,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    Price,
    Status,
    TotalQuantity,
    AvailableQuantity,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _Event : redirected to parent ZC_TH_EVENT
}
