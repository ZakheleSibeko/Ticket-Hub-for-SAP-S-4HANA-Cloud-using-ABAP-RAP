CLASS lhc_ZI_TH_SERVICE_ITEM DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR ServiceItem RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR ServiceItem RESULT result.

    METHODS Activates FOR MODIFY
      IMPORTING keys FOR ACTION ServiceItem~Activates RESULT result.

    METHODS Deactivate FOR MODIFY
      IMPORTING keys FOR ACTION ServiceItem~Deactivate RESULT result.

    METHODS SetInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ServiceItem~SetInitialStatus.

    METHODS ValidatePrice FOR VALIDATE ON SAVE
      IMPORTING keys FOR ServiceItem~ValidatePrice.

ENDCLASS.

CLASS lhc_ZI_TH_SERVICE_ITEM IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD Activates.
      MODIFY ENTITIES OF ZI_TH_SERVICE_ITEM IN LOCAL MODE
                  ENTITY ServiceItem
                  UPDATE FIELDS ( Status )
                  WITH VALUE #( FOR key IN keys
                          (
                           %tky = key-%tky
                           Status = 'ACTIVATED'
                          )
                         ).
       READ ENTITIES OF ZI_TH_SERVICE_ITEM IN LOCAL MODE
                 ENTITY ServiceItem
                 FIELDS ( Status )
                 WITH CORRESPONDING #( keys )
                 RESULT DATA(services).

       result = VALUE #( FOR service IN services
                        (
                          %tky = service-%tky
                          %param = service
                        )
                      ).
  ENDMETHOD.

  METHOD Deactivate.
             MODIFY ENTITIES OF ZI_TH_SERVICE_ITEM IN LOCAL MODE
                  ENTITY ServiceItem
                  UPDATE FIELDS ( Status )
                  WITH VALUE #( FOR key IN keys
                          (
                           %tky = key-%tky
                           Status = 'DEACTIVATED'
                          )
                         ).
       READ ENTITIES OF ZI_TH_SERVICE_ITEM IN LOCAL MODE
                 ENTITY ServiceItem
                 FIELDS ( Status )
                 WITH CORRESPONDING #( keys )
                 RESULT DATA(services).

       result = VALUE #( FOR service IN services
                        (
                          %tky = service-%tky
                          %param = service
                        )
                      ).
  ENDMETHOD.

  METHOD SetInitialStatus.
         MODIFY ENTITIES OF ZI_TH_SERVICE_ITEM IN LOCAL MODE
                     ENTITY ServiceItem
                     UPDATE FIELDS ( Status )
                     WITH VALUE #( FOR key IN keys
                                (
                                 %tky   = key-%tky
                                 Status = 'DRAFT'
                                )
                              ).
  ENDMETHOD.

  METHOD ValidatePrice.

        READ ENTITIES OF ZI_TH_SERVICE_ITEM IN LOCAL MODE
                   ENTITY ServiceItem
                   FIELDS ( UnitPrice )
                   WITH CORRESPONDING #( keys )
                   RESULT DATA(lt_prices).

        LOOP AT lt_prices INTO DATA(lt_price).
            IF lt_price-UnitPrice IS INITIAL.
              APPEND VALUE #(
                             %tky = lt_price-%tky
                             %msg = new_message_with_text(
                                               severity = if_abap_behv_message=>severity-error
                                               text     = 'Only prices above 0 can be validated'
                             )
                           ) TO reported-serviceitem.
            ENDIF.
        ENDLOOP.
  ENDMETHOD.

ENDCLASS.
