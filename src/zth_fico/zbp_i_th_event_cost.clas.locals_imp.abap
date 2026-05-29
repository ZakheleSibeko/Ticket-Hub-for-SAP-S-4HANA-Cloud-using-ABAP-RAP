CLASS lhc_ZI_TH_EVENT_COST DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR EventCost RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR EventCost RESULT result.

    METHODS ApproveCost FOR MODIFY
      IMPORTING keys FOR ACTION EventCost~ApproveCost RESULT result.

    METHODS SetInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR EventCost~SetInitialStatus.

    METHODS ValidateAmount FOR VALIDATE ON SAVE
      IMPORTING keys FOR EventCost~ValidateAmount.

ENDCLASS.

CLASS lhc_ZI_TH_EVENT_COST IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD ApproveCost.
    MODIFY ENTITIES OF ZI_TH_EVENT_COST IN LOCAL MODE
                ENTITY EventCost
                UPDATE FIELDS ( Status )
                WITH VALUE #( FOR key IN keys
                          (
                           %tky   = key-%tky
                           Status = 'APPROVED'
                          )
                       ).
  ENDMETHOD.

  METHOD SetInitialStatus.
    MODIFY ENTITIES OF ZI_TH_EVENT_COST IN LOCAL MODE
               ENTITY EventCost
               UPDATE FIELDS ( Status )
               WITH VALUE #( FOR key IN keys
                 (
                  %tky   = key-%tky
                  Status = 'POSTED'
                 )
               ).
  ENDMETHOD.

  METHOD ValidateAmount.
    READ ENTITIES OF ZI_TH_EVENT_COST IN LOCAL MODE
              ENTITY EventCost
              ALL FIELDS
              WITH CORRESPONDING #( keys )
              RESULT DATA(costs).

    LOOP AT costs ASSIGNING FIELD-SYMBOL(<cost>).
     IF <cost>-Amount <= 0.
       APPEND VALUE #(
          %tky = <cost>-%tky
          %msg = new_message_with_text(
                          severity = if_abap_behv_message=>severity-error
                          text     = 'Only amount greater than 0 can be calculated'
          )
        ) TO reported-eventcost.
        APPEND VALUE #( %tky = <cost>-%tky ) TO failed-eventcost.
        CONTINUE.
     ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
