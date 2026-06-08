CLASS lhc_ZI_TH_ONEORDER_HDR DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Header RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Header RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Header RESULT result.

    METHODS submit FOR MODIFY
      IMPORTING keys FOR ACTION Header~submit RESULT result.

    METHODS setInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Header~setInitialStatus.

    METHODS checkmandatoryPartners FOR VALIDATE ON SAVE
      IMPORTING keys FOR Header~checkmandatoryPartners.

ENDCLASS.

CLASS lhc_ZI_TH_ONEORDER_HDR IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD submit.
     MODIFY ENTITIES OF ZI_TH_ONEORDER_HDR IN LOCAL MODE
                 ENTITY Header
                 UPDATE FIELDS ( Status )
                 WITH VALUE #( FOR key IN keys
                              (
                               %tky = key-%tky
                               Status = 'SUBMITTED'
                              )
                         ).
  ENDMETHOD.

  METHOD setInitialStatus.

     READ ENTITIES OF ZI_TH_ONEORDER_HDR IN LOCAL MODE
               ENTITY Header
               ALL FIELDS WITH CORRESPONDING #( keys )
               RESULT DATA(headers).

      LOOP AT headers INTO DATA(header).
        MODIFY ENTITIES OF ZI_TH_ONEORDER_HDR IN LOCAL MODE
                    ENTITY Header
                    UPDATE FIELDS ( Status )
                    WITH VALUE #(
                                ( %tky = header-%tky
                                  Status = 'OPEN' )
                                  )
                  CREATE BY \_Status
                  FIELDS ( Status Active )
                  WITH VALUE #( (
                                 %tky = header-%tky
                                 %target =  VALUE #(
                                                    ( Status = 'OPEN'
                                                     Active = 'X'
                                                     %cid   = 'INITIALSTATUS' ) ) ) ) REPORTED DATA(lt_reported).
          reported = CORRESPONDING #( DEEP lt_reported ).
      ENDLOOP.
  ENDMETHOD.

  METHOD checkmandatoryPartners.

        READ ENTITIES OF ZI_TH_ONEORDER_HDR IN LOCAL MODE
                   ENTITY Header
                   ALL FIELDS WITH CORRESPONDING #( keys )
                   RESULT DATA(headers)
                 BY \_Partner
                 ALL FIELDS WITH CORRESPONDING #( keys )
                   RESULT DATA(partners).

        LOOP AT headers INTO DATA(header).
         IF NOT line_exists( partners[ PartnerFunction = 'SOLD-TO' ] ).
           APPEND VALUE #( %tky = header-%tky ) TO failed-header.
           APPEND VALUE #(
                           %tky =  header-%tky
                           %msg = new_message_with_text(
                                                        severity = if_abap_behv_message=>severity-error
                                                        text     = 'Atlease one SOLD-TO partner required'
                                                        )
           ) TO reported-header.
         ENDIF.
        ENDLOOP.

  ENDMETHOD.

ENDCLASS.
