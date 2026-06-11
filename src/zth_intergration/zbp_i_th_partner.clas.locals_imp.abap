CLASS lhc_ZI_TH_PARTNER DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Partner RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Partner RESULT result.

    METHODS Activated FOR MODIFY
      IMPORTING keys FOR ACTION Partner~Activated RESULT result.

    METHODS Deactivated FOR MODIFY
      IMPORTING keys FOR ACTION Partner~Deactivated RESULT result.

ENDCLASS.

CLASS lhc_ZI_TH_PARTNER IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD Activated.
       MODIFY ENTITIES OF ZI_TH_PARTNER IN LOCAL MODE
                   ENTITY Partner
                   UPDATE FIELDS ( Status )
                   WITH VALUE #( FOR key IN keys
                                (
                                  %tky = key-%tky
                                  Status = 'ACTIVATED'
                                 )
                                ).
  ENDMETHOD.

  METHOD Deactivated.
       MODIFY ENTITIES OF ZI_TH_PARTNER IN LOCAL MODE
                   ENTITY Partner
                   UPDATE FIELDS ( Status )
                   WITH VALUE #( FOR key IN keys
                               (
                                %tky = key-%tky
                                Status = 'DEACTIVATED'
                               )
                             ).
  ENDMETHOD.

ENDCLASS.
