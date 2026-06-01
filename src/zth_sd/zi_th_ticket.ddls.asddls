@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ticket database table'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TH_TICKET as select from zth_ticket
association to ZI_TH_BOOKING_SD as _Booking
  on $projection.BookingId = _Booking.BookingId 
{
    key ticket_id as TicketId,
    booking_id as BookingId,
    event_id as EventId,
    qr_code as QrCode,
    issue_date as IssueDate,
    status as Status,
    _Booking
}
