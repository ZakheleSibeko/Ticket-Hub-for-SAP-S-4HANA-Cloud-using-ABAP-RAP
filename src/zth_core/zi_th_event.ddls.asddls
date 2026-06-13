@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Ticket Hub Event'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZI_TH_EVENT
  as select from zth_event
  composition [0..*] of ZI_TH_TICKET_TYPE  as _Ticket_type
  composition [0..*] of ZI_TH_BOOKING      as _Booking
  composition [0..*] of ZI_TH_BOOKING_ITEM as _Booking_item 
{
  @UI.identification: [{ label: 'EventId' }]
  key event_id              as EventId,
      @UI.identification: [{ label: 'EventName' }]
      event_name            as EventName,
      @UI.identification: [{ label: 'EventDetails' }]
      event_details         as EventDetails,
      @UI.identification: [{ label: 'EventType' }]
      event_type            as EventType,
      @UI.identification: [{ label: 'StartDate' }]
      start_date            as StartDate,
      @UI.identification: [{ label: 'EndDate' }]
      end_date              as EndDate,
      @UI.identification: [{ label: 'Venue' }]
      venue                 as Venue,
      @UI.identification: [{ label: 'City' }]
      city                  as City,
      @UI.identification: [{ label: 'Status' }]
      status                as Status,
      @UI.identification: [{ label: 'TotalCapacity' }]
      total_capacity        as TotalCapacity,
      @UI.identification: [{ label: 'AvailableCapacity' }]
      available_capacity    as AvailableCapacity,
      @UI.identification: [{ label: 'OrganizerId' }]
      organizer_id          as OrganizerId,
      @UI.identification: [{ label: 'CurrencyCode' }]
      currency_code         as CurrencyCode,
      @UI.identification: [{ label: 'CreatedBy' }]
      created_by            as CreatedBy,
      @UI.identification: [{ label: 'CreatedAt' }]
      created_at            as CreatedAt,
      @UI.identification: [{ label: 'LastChangedBy' }]
      last_changed_by       as LastChangedBy,
      @UI.identification: [{ label: 'LastChangedAt' }]
      last_changed_at       as LastChangedAt,
      @UI.identification: [{ label: 'LocalLastChangedAt' }]
      local_last_changed_at as LocalLastChangedAt,
      _Ticket_type,
      _Booking,
      _Booking_item
}
