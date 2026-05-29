@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Event cost CDS projecton view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_TH_EVENT_COST 
provider contract transactional_query
as projection on ZI_TH_EVENT_COST
{
    key CostId,
    EventId,
    CostCategory,
    Description,
    Amount,
    CurrencyCode,
    VendorId,
    PostingDate,
    Status,
    CreatedBy,
    CreatedAt,
    LocalLastchangedBy,
    LocalLastchangedAt,
    _Event
}
