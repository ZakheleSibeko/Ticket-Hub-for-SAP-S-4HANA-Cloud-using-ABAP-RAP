@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'API LOG CDS view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_TH_API_LOG as select from zth_api_log
association to parent ZI_TH_PARTNER as _Partner
    on $projection.PartnerId = _Partner.PartnerId
{
    key log_id as LogId,
    partner_id as PartnerId,
    message_type as MessageType,
    direction as Direction,
    status as Status,
    request_payload as RequestPayload,
    response_payload as ResponsePayload,
    created_at as CreatedAt,
    _Partner
}
