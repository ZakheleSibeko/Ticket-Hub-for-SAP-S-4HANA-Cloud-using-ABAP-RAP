@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ticket type'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_TH_TICKET_TYPE
  as select from zth_ticket_type
  association to parent ZI_TH_EVENT as _Event on $projection.EventId = _Event.EventId
{
  key ticket_type_id        as TicketTypeId,
      event_id              as EventId,
      ticket_type_name      as TicketTypeName,
      currency_code         as CurrencyCode,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price                 as Price,
      status                as Status,
      total_quantity        as TotalQuantity,
      available_quantity    as AvailableQuantity,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      last_changed_by       as LastChangedBy,
      last_changed_at       as LastChangedAt,
      local_last_changed_at as LocalLastChangedAt,
      _Event // Make association public
}
