@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Partner MSG CDS view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_TH_PARTNER_MSG as select from zth_partner_msg
association to parent ZI_TH_PARTNER as _Partner
    on $projection.PartnerId = _Partner.PartnerId
{
    key message_id as MessageId,
    partner_id as PartnerId,
    object_type as ObjectType,
    object_id as ObjectId,
    status as Status,
    payload as Payload,
    _Partner // Make association public
}
