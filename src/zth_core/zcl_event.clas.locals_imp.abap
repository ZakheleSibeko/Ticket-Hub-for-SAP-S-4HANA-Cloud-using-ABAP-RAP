CLASS lcl_event DEFINITION.

  PUBLIC SECTION.

     TYPES tt_event TYPE TABLE OF zth_event.

     METHODS constructor
         IMPORTING
            iv_event_id           TYPE zth_event-event_id
            iv_event_name         TYPE zth_event-event_name
            iv_event_type         TYPE zth_event-event_type
            iv_start_date         TYPE zth_event-start_date
            iv_end_date           TYPE zth_event-end_date
            iv_total_capacity     TYPE zth_event-total_capacity
            iv_available_capacity TYPE zth_event-available_capacity.

      METHODS validate_event
            IMPORTING
               iv_event_id   TYPE zth_event-event_id
               iv_event_name TYPE zth_event-event_name
             RETURNING VALUE(rv_validate) TYPE abap_bool
               RAISING cx_abap_invalid_value.

       METHODS event_exist
            IMPORTING
               iv_event_id   TYPE zth_event-event_id
               iv_event_name TYPE zth_event-event_name
             RETURNING VALUE(rv_exist) TYPE abap_bool
               RAISING cx_abap_invalid_value.

       METHODS event_is_valid
           IMPORTING
              iv_event_id    TYPE zth_event-event_id
              iv_event_name  TYPE zth_event-event_name
              iv_start_date  TYPE zth_event-start_date
              iv_end_date    TYPE zth_event-end_date
            EXPORTING
              ev_total_capacity     TYPE int4
              ev_available_capacity TYPE int4
              RAISING cx_abap_invalid_value.

  PROTECTED SECTION.
            DATA event_id           TYPE zth_event-event_id.
            DATA event_name         TYPE zth_event-event_name.
            DATA event_type         TYPE zth_event-event_type.
            DATA start_date         TYPE zth_event-start_date.
            DATA end_date           TYPE zth_event-end_date.
            DATA total_capacity     TYPE zth_event-total_capacity.
            DATA available_capacity TYPE zth_event-available_capacity.

    DATA event_table TYPE tt_event.

  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_event IMPLEMENTATION.

  METHOD constructor.
         event_id           = iv_event_id.
         event_name         = iv_event_name.
         event_type         = iv_event_type.
         start_date         = iv_start_date.
         end_date           = iv_end_date.
         total_capacity     = iv_total_capacity.
         available_capacity = iv_available_capacity.
  ENDMETHOD.

  METHOD validate_event.
        SELECT SINGLE *
               FROM ZTH_EVENT
               WHERE event_id = @iv_event_id
               INTO @DATA(ls_validate).

        IF ls_validate-event_id IS INITIAL
         OR ls_validate-event_name IS INITIAL
         OR ls_validate-start_date IS INITIAL.
              rv_validate =  abap_false.
          ELSE.
            DATA(lo_event) = zcl_factory_event=>create_event( is_event = ls_validate ).
            TRY.
             rv_validate = lo_event->calculate_available_capacity( ).
            CATCH cx_abap_invalid_value.
            ENDTRY.
        ENDIF.

  ENDMETHOD.

  METHOD event_exist.

         SELECT SINGLE *
                FROM ZTH_EVENT
                WHERE event_id = @iv_event_id
                INTO @DATA(ls_exist).

         IF sy-subrc = 0.
            rv_exist = abap_true.

             event_table = VALUE #(
                                   ( event_id = ls_exist-event_id
                                     event_name = ls_exist-event_name
                                     event_type = ls_exist-event_type
                                    )
                                  ).
            ELSE.
               rv_exist = abap_false.
               DATA(lo_event) = zcl_factory_event=>create_event( is_event = ls_exist ).
         ENDIF.

  ENDMETHOD.

  METHOD event_is_valid.

    SELECT SINGLE *
           FROM  zth_event
           WHERE event_id = @iv_event_id
           INTO @DATA(ls_valid).

     IF sy-subrc <> 0
     AND ls_valid-event_id IS NOT INITIAL
     AND ls_valid-event_name IS NOT INITIAL
     AND start_date <= end_date.

       DATA(lo_event) = zcl_factory_event=>create_event( is_event = ls_valid ).
     ENDIF.
  ENDMETHOD.

ENDCLASS.

************************************************************************************************************************************************

CLASS lcl_event_finance DEFINITION INHERITING FROM lcl_event.

  PUBLIC SECTION.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_event_finance IMPLEMENTATION.

ENDCLASS.

*************************************************************************************************************************************************

CLASS lcl_event_HR DEFINITION INHERITING FROM lcl_event.

  PUBLIC SECTION.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_event_HR IMPLEMENTATION.

ENDCLASS.
