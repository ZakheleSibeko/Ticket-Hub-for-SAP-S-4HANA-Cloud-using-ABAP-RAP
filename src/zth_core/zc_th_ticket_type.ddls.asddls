@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ticket type projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_TH_TICKET_TYPE
 as projection on ZI_TH_TICKET_TYPE
{
    @EndUserText.label: 'TicketTypeId'
    key TicketTypeId,
    @EndUserText.label: 'EventId'
    EventId,
    @EndUserText.label: 'TicketTypeName'
    TicketTypeName,
    @EndUserText.label: 'CurrencyCode'
    CurrencyCode,
    @EndUserText.label: 'Price'
    @Semantics.amount.currencyCode: 'CurrencyCode'
    Price,
    @EndUserText.label: 'Status'
    Status,
    @EndUserText.label: 'TotalQuantity'
    TotalQuantity,
    @EndUserText.label: 'AvailableQuantity'
    AvailableQuantity,
    @EndUserText.label: 'CreatedBy'
    CreatedBy,
    @EndUserText.label: 'CreatedAt'
    CreatedAt,
    @EndUserText.label: 'LastChangedBy'
    LastChangedBy,
    @EndUserText.label: 'LastChangedAt'
    LastChangedAt,
    @EndUserText.label: 'LocalLastChangedAt'
    LocalLastChangedAt,
    /* Associations */
    _Event : redirected to parent ZC_TH_EVENT
}
