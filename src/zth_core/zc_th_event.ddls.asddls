@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Ticket Hub Event projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_TH_EVENT
 provider contract transactional_query
 as projection on ZI_TH_EVENT
{
    key EventId,
    EventName,
    EventDetails,
    EventType,
    StartDate,
    EndDate,
    Venue,
    City,
    Status,
    TotalCapacity,
    AvailableCapacity,
    OrganizerId,
    CurrencyCode,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _Booking : redirected to composition child ZC_TH_BOOKING,
    _Ticket_type : redirected to composition child ZC_TH_TICKET_TYPE,
   _Booking_item : redirected to composition child ZC_TH_BOOKING_ITEM
}
