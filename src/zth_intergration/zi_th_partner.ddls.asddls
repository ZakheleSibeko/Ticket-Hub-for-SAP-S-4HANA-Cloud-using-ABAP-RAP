@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Partner CDS view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TH_PARTNER as select from zth_partner
 composition [0..*] of ZI_TH_PARTNER_MSG  as _Messaging
 composition [0..*] of ZI_TH_API_LOG      as _API_LOG     
{
    key partner_id as PartnerId,
    partner_name as PartnerName,
    partner_type as PartnerType,
    endpoint_url as EndpointUrl,
    api_key as ApiKey,
    status as Status,
    _Messaging,
    _API_LOG 
}
