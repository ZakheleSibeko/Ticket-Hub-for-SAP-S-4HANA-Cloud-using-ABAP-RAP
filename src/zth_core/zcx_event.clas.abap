CLASS zcx_event DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    CONSTANTS: BEGIN OF event_name_missing,
               msgid TYPE symsgid VALUE 'ZTH_MSG',
               msgno TYPE symsgno VALUE '001',
               attr1 TYPE scx_attrname VALUE '',
               attr2 TYPE scx_attrname VALUE '',
               attr3 TYPE scx_attrname VALUE '',
               attr4 TYPE scx_attrname VALUE '',
               END OF event_name_missing,

     BEGIN OF invalid_dates,
              msgid TYPE symsgid VALUE 'ZTH_MSG',
              msgno TYPE symsgno VALUE '002',
              attr1 TYPE scx_attrname VALUE '',
              attr2 TYPE scx_attrname VALUE '',
              attr3 TYPE scx_attrname VALUE '',
              attr4 TYPE scx_attrname VALUE '',
              END OF invalid_dates,

     BEGIN OF invalid_capacity,
              msgid TYPE symsgid VALUE 'ZTH_MSG',
              msgno TYPE symsgno VALUE '003',
              attr1 TYPE scx_attrname VALUE '',
              attr2 TYPE scx_attrname VALUE '',
              attr3 TYPE scx_attrname VALUE '',
              attr4 TYPE scx_attrname VALUE '',
              END OF invalid_capacity.

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_event IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(
    previous = previous
    ).
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
