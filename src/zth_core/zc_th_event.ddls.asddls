@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Ticket Hub Event projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_TH_EVENT
 provider contract transactional_query
 as projection on ZI_TH_EVENT
{
    @EndUserText.label: 'EventId'
    key EventId,
    @EndUserText.label: 'EventName'
    EventName,
    @EndUserText.label: 'EventDetails'
    EventDetails,
    @EndUserText.label: 'EventType'
    EventType,
    @EndUserText.label: 'StartDate'
    StartDate,
    @EndUserText.label: 'EndDate'
    EndDate,
    @EndUserText.label: 'Venue'
    Venue,
    @EndUserText.label: 'City'
    City,
    @EndUserText.label: 'Status'
    Status,
    @EndUserText.label: 'TotalCapacity'
    TotalCapacity,
    @EndUserText.label: 'AvailableCapacity'
    AvailableCapacity,
    @EndUserText.label: 'OrganizerId'
    OrganizerId,
    @EndUserText.label: 'CurrencyCode'
    CurrencyCode,
    @Semantics.user.createdBy: true
    @EndUserText.label: 'CreatedBy'
    CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    @EndUserText.label: 'CreatedAt'
    CreatedAt,
    @Semantics.user.lastChangedBy: true
    @EndUserText.label: 'LastChangedBy'
    LastChangedBy,
    @Semantics.systemDateTime.lastChangedAt: true
    @EndUserText.label: 'LastChangedAt'
    LastChangedAt,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    @EndUserText.label: 'LocalLastChangedAt'
    LocalLastChangedAt,

    /* Associations */
    _Booking : redirected to composition child ZC_TH_BOOKING,
    _Ticket_type : redirected to composition child ZC_TH_TICKET_TYPE,
   _Booking_item : redirected to composition child ZC_TH_BOOKING_ITEM
}
