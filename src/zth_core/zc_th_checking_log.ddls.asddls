@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ticket Hub checking log projection'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_TH_CHECKING_LOG 
  provider contract transactional_query
  as projection on ZI_TH_CHECKING_LOG
{
    key CheckingId,
    BookingId,
    EventId,
    CheckingTime,
    CheckingBy,
    Status,
    Message,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    /* Associations */
    _Booking,
    _Event
}
