@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Workflow step CDS view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_TH_WF_STEP as select from zth_wf_step
association to parent ZI_TH_WF_HEADER as _Header
    on $projection.WfId = _Header.WfId
{
    key step_id as StepId,
    wf_id as WfId,
    step_no as StepNo,
    approver_id as ApproverId,
    status as Status,
    comments as Comments,
    desicion_date as DesicionDate,
    _Header // Make association public
}
