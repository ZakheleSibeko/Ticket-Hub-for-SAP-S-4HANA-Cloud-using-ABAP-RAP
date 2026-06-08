@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Business partner CDS projection view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_TH_I_BUSINESSPARTNER 
 provider contract transactional_query
 as projection on ZI_TH_I_BusinessPartner
{
    key BpId,
    BpType,
    FirstName,
    LastName,
    Email,
    Phone,
    Status,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt
}
