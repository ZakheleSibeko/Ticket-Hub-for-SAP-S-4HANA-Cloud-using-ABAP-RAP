@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ticket Hub checking log'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TH_CHECKING_LOG 
  as select from zth_checking_log
  association [1] to ZI_TH_BOOKING as _Booking
   on $projection.BookingId = _Booking.BookingId
   
  association [1] to ZI_TH_EVENT as _Event
   on $projection.EventId = _Event.EventId
{
    key checking_id as CheckingId,
    booking_id as BookingId,
    event_id as EventId,
    checking_time as CheckingTime,
    checking_by as CheckingBy,
    status as Status,
    message as Message,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    _Booking,
    _Event
}
