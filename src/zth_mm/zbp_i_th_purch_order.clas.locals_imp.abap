CLASS lhc_ZI_TH_PURCH_ORDER DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR PurchOrder RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR PurchOrder RESULT result.

    METHODS CancelPO FOR MODIFY
      IMPORTING keys FOR ACTION PurchOrder~CancelPO RESULT result.

    METHODS ClosePO FOR MODIFY
      IMPORTING keys FOR ACTION PurchOrder~ClosePO RESULT result.

    METHODS ReleasePO FOR MODIFY
      IMPORTING keys FOR ACTION PurchOrder~ReleasePO RESULT result.

    METHODS SetInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR PurchOrder~SetInitialStatus.

    METHODS ValidateAmount FOR VALIDATE ON SAVE
      IMPORTING keys FOR PurchOrder~ValidateAmount.

ENDCLASS.

CLASS lhc_ZI_TH_PURCH_ORDER IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD CancelPO.
     MODIFY ENTITIES OF ZI_TH_PURCH_ORDER IN LOCAL MODE
                 ENTITY PurchOrder
                 UPDATE FIELDS ( Status )
                 WITH VALUE #(
                   FOR key IN keys
                    (
                    %tky   = key-%tky
                    Status = 'CANCELLED'
                    )
                 ).
      READ ENTITIES OF ZI_TH_PURCH_ORDER IN LOCAL MODE
                ENTITY PurchOrder
                FIELDS ( Status )
                WITH CORRESPONDING #( keys )
                RESULT DATA(orders).

      result = VALUE #(
               FOR order IN orders
               (
                %tky = order-%tky
                %param = order
               )
       ).
  ENDMETHOD.

  METHOD ClosePO.
         MODIFY ENTITIES OF ZI_TH_PURCH_ORDER IN LOCAL MODE
                 ENTITY PurchOrder
                 UPDATE FIELDS ( Status )
                 WITH VALUE #(
                   FOR key IN keys
                    (
                    %tky   = key-%tky
                    Status = 'CLOSED'
                    )
                 ).
      READ ENTITIES OF ZI_TH_PURCH_ORDER IN LOCAL MODE
                ENTITY PurchOrder
                FIELDS ( Status )
                WITH CORRESPONDING #( keys )
                RESULT DATA(orders).

      result = VALUE #(
               FOR order IN orders
               (
                %tky = order-%tky
                %param = order
               )
       ).
  ENDMETHOD.

  METHOD ReleasePO.
       MODIFY ENTITIES OF ZI_TH_PURCH_ORDER IN LOCAL MODE
                 ENTITY PurchOrder
                 UPDATE FIELDS ( Status )
                 WITH VALUE #(
                   FOR key IN keys
                    (
                    %tky   = key-%tky
                    Status = 'RELEASED'
                    )
                 ).
      READ ENTITIES OF ZI_TH_PURCH_ORDER IN LOCAL MODE
                ENTITY PurchOrder
                FIELDS ( Status )
                WITH CORRESPONDING #( keys )
                RESULT DATA(orders).

      result = VALUE #(
               FOR order IN orders
               (
                %tky = order-%tky
                %param = order
               )
       ).
  ENDMETHOD.

  METHOD SetInitialStatus.

       MODIFY ENTITIES OF ZI_TH_PURCH_ORDER IN LOCAL MODE
                   ENTITY PurchOrder
                   UPDATE FIELDS ( Status )
                   WITH VALUE #( FOR key IN keys
                            (
                             %tky   = key-%tky
                             Status = 'DRAFT'
                            )
                         ).

  ENDMETHOD.

  METHOD ValidateAmount.

        READ ENTITIES OF ZI_TH_PURCH_ORDER IN LOCAL MODE
                  ENTITY PurchOrder
                  FIELDS ( TotalAmount )
                  WITH CORRESPONDING #( keys )
                  RESULT DATA(orders).

        LOOP AT orders INTO DATA(order).
          IF order-TotalAmount IS INITIAL.
            APPEND VALUE #(
                         %tky = order-%tky
                         %msg = new_message_with_text(
                                         severity = if_abap_behv_message=>severity-error
                                         text     = 'Amount need to be greater than 0.'
                                )
                         ) TO reported-purchorder.
          ENDIF.
        ENDLOOP.

  ENDMETHOD.

ENDCLASS.
