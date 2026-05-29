@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Event cost CDS view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TH_EVENT_COST
  as select from zth_event_cost
  association to ZI_TH_EVENT as _Event
   on $projection.EventId = _Event.EventId
{
  key cost_id              as CostId,
      event_id             as EventId,
      cost_category        as CostCategory,
      description          as Description,
      amount               as Amount,
      currency_code        as CurrencyCode,
      vendor_id            as VendorId,
      posting_date         as PostingDate,
      status               as Status,
      created_by           as CreatedBy,
      created_at           as CreatedAt,
      local_lastchanged_by as LocalLastchangedBy,
      local_lastchanged_at as LocalLastchangedAt,
      _Event 
}
