@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Workflow log CDS view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_TH_WF_LOG as select from zth_wf_log
association to parent ZI_TH_WF_HEADER as _Header
    on $projection.WfId = _Header.WfId
{
    key log_id as LogId,
    wf_id as WfId,
    action as Action,
    user_id as UserId,
    action_date as ActionDate,
    comments as Comments,
    _Header // Make association public
}
