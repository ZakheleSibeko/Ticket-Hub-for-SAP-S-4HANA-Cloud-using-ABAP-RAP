@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Oppurtunity CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_TH_OPPORTUNITY
 provider contract transactional_query 
 as projection on ZI_TH_OPPORTUNITY
{
    key OpportunityId,
    BpId,
    EventId,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    ExpectedRevenue,
    CurrencyCode,
    Stage,
    Status,
    /* Associations */
    _BusinessPartner
}
