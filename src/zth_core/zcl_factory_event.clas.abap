CLASS zcl_factory_event DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS create_event
         IMPORTING
            is_event TYPE zth_event
         RETURNING VALUE(ro_event) TYPE REF TO zif_event.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_factory_event IMPLEMENTATION.
  METHOD create_event.
      CASE is_event-event_type.
        WHEN 'Conference'.
           ro_event = NEW zcl_conference_event( is_event ).

        WHEN 'Concert'.
           ro_event = NEW zcl_concert_event( is_event ).

        WHEN 'sport'.
           ro_event = NEW zcl_sport_event( is_event ).
      ENDCASE.
  ENDMETHOD.

ENDCLASS.
