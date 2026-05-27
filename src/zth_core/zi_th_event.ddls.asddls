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
  key event_id              as EventId,
      event_name            as EventName,
      event_details         as EventDetails,
      event_type            as EventType,
      start_date            as StartDate,
      end_date              as EndDate,
      venue                 as Venue,
      city                  as City,
      status                as Status,
      total_capacity        as TotalCapacity,
      available_capacity    as AvailableCapacity,
      organizer_id          as OrganizerId,
      currency_code         as CurrencyCode,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      last_changed_by       as LastChangedBy,
      last_changed_at       as LastChangedAt,
      local_last_changed_at as LocalLastChangedAt,
      _Ticket_type,
      _Booking,
      _Booking_item
}
