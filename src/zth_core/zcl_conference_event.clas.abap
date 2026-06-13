CLASS zcl_conference_event DEFINITION
  PUBLIC
  INHERITING FROM zcl_abs_event
  CREATE PUBLIC .

  PUBLIC SECTION.

  METHODS constructor
      IMPORTING
        is_event TYPE zth_event.

  METHODS zif_event~calculate_available_capacity REDEFINITION.
  METHODS zif_event~calculate_estimated_revenue  REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_conference_event IMPLEMENTATION.

   METHOD constructor.
    super->constructor(
       is_event = is_event
       ).
     mv_name = is_event-event_name.
     mv_event_id = is_event-event_id.
  ENDMETHOD.

  METHOD zif_event~calculate_available_capacity.
      rv_capacity = mv_total_capacity - mv_available_capacity.
  ENDMETHOD.

  METHOD zif_event~calculate_estimated_revenue.
       rv_revenue = mv_total_capacity * '150'.
  ENDMETHOD.



ENDCLASS.
