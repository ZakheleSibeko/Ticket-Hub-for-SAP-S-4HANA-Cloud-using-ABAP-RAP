CLASS lhc_ZI_TH_WF_HEADER DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Header RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Header RESULT result.

    METHODS Approve FOR MODIFY
      IMPORTING keys FOR ACTION Header~Approve RESULT result.

    METHODS Reject FOR MODIFY
      IMPORTING keys FOR ACTION Header~Reject RESULT result.

    METHODS Submit FOR MODIFY
      IMPORTING keys FOR ACTION Header~Submit RESULT result.

ENDCLASS.

CLASS lhc_ZI_TH_WF_HEADER IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD Approve.
    MODIFY ENTITIES OF ZI_TH_WF_HEADER IN LOCAL MODE
                 ENTITY Header
                 UPDATE FIELDS ( Status CompletedAt )
                 WITH VALUE #( FOR key IN keys
                             (
                              %tky = key-%tky
                              Status = 'APPROVED'
                              CompletedAt = cl_abap_context_info=>get_system_time( )
                             )
                           ).
  ENDMETHOD.

  METHOD Reject.
       MODIFY ENTITIES OF ZI_TH_WF_HEADER IN LOCAL MODE
                   ENTITY Header
                   UPDATE FIELDS ( Status CompletedAt )
                   WITH VALUE #( FOR key IN keys
                               (
                                %tky = key-%tky
                                Status = 'REJECTED'
                                CompletedAt = cl_abap_context_info=>get_system_time( )
                               )
                              ).
  ENDMETHOD.

  METHOD Submit.
         MODIFY ENTITIES OF ZI_TH_WF_HEADER IN LOCAL MODE
                     ENTITY Header
                     UPDATE FIELDS ( Status CompletedAt )
                     WITH VALUE #( FOR key IN keys
                                 (
                                  %tky = key-%tky
                                  Status = 'SUBMITTED'
                                  CompletedAt = cl_abap_context_info=>get_system_time( )
                                 )
                                ).
  ENDMETHOD.

ENDCLASS.
