CLASS zcl_abs_event DEFINITION
  PUBLIC
  ABSTRACT.

  PUBLIC SECTION.

    INTERFACES zif_event .

    METHODS constructor
        IMPORTING
            is_event TYPE zth_event.

  PROTECTED SECTION.

     DATA:
        mv_event_id           TYPE sysuuid_x16,
        mv_name               TYPE zth_event-event_name,
        mv_start_date         TYPE zth_event-start_date,
        mv_end_date           TYPE zth_event-end_date,
        mv_total_capacity     TYPE zth_event-total_capacity,
        mv_available_capacity TYPE zth_event-available_capacity,
        mv_event_type         TYPE zth_event-event_type.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abs_event IMPLEMENTATION.

  METHOD constructor.
        mv_event_id           = is_event-event_id.
        mv_name               = is_event-event_name.
        mv_start_date         = is_event-start_date.
        mv_end_date           = is_event-end_date.
        mv_total_capacity     = is_event-total_capacity.
        mv_available_capacity = is_event-available_capacity.
        mv_event_type         = is_event-event_type.
  ENDMETHOD.

  METHOD zif_event~calculate_available_capacity.
     rv_capacity = mv_total_capacity - mv_available_capacity.
     IF rv_capacity < 0.
      rv_capacity = 0.
     ENDIF.
  ENDMETHOD.

  METHOD zif_event~calculate_duration.
     rv_days = mv_start_date - mv_end_date.
  ENDMETHOD.

  METHOD zif_event~calculate_estimated_revenue.
     rv_revenue = mv_total_capacity.
  ENDMETHOD.

  METHOD zif_event~validate_event.
     IF mv_name IS INITIAL.
       RAISE EXCEPTION TYPE zcx_event
         EXPORTING
             textid = zcx_event=>event_name_missing.
     ENDIF.

     IF mv_start_date > mv_end_date.
       RAISE EXCEPTION TYPE zcx_event
           EXPORTING
             textid = zcx_event=>invalid_dates.
     ENDIF.

     IF mv_total_capacity <= 0.
      RAISE EXCEPTION TYPE zcx_event
          EXPORTING
              textid = zcx_event=>invalid_capacity.
     ENDIF.

  ENDMETHOD.

ENDCLASS.
