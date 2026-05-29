@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Event Profitability'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_TH_EVENT_PROFITABILITY 
  as select from ZI_TH_EVENT as event
  left outer join zth_booking as booking
   on booking.event_id = event.EventId
  left outer join zth_refund as refund
   on refund.booking_id = booking.booking_id
  left outer join zth_event_cost as cost 
   on cost.event_id = event.EventId
{
    key event.EventId as EventId,
    event.EventName   as EventName,
    sum( booking.net_amount ) as Revenue,
    sum( refund.refund_amount ) as Refunds,
    sum( cost.amount ) as Costs,
    
    (
     sum( booking.net_amount) 
     - sum( refund.refund_amount)
     - sum( cost.amount )
    ) as profit
        
}

group by 
event.EventId,
event.EventName
