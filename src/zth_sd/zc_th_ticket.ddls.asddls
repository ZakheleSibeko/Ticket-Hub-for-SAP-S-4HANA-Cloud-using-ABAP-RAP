@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ticket projection view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_TH_TICKET 
 provider contract transactional_query
 as projection on ZI_TH_TICKET
{
    key TicketId,
    BookingId,
    EventId,
    QrCode,
    IssueDate,
    Status,
    /* Associations */
    _Booking
}
