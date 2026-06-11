@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header CDS view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TH_WF_HEADER as select from zth_wf_header
 composition [0..*] of ZI_TH_WF_STEP as _Step
 composition [0..*] of ZI_TH_WF_LOG  as _Log
{
    key wf_id as WfId,
    object_type as ObjectType,
    object_id as ObjectId,
    status as Status,
    started_by as StartedBy,
    started_at as StartedAt,
    completed_at as CompletedAt,
    last_changed_at as LastChangedAt,
    _Step,
    _Log
}
