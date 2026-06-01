CLASS lhc_PurchaseReq DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR PurchaseReq RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR PurchaseReq RESULT result.

    METHODS ApprovePR FOR MODIFY
      IMPORTING keys FOR ACTION PurchaseReq~ApprovePR RESULT result.

    METHODS CreatePO FOR MODIFY
      IMPORTING keys FOR ACTION PurchaseReq~CreatePO RESULT result.

    METHODS RejectPR FOR MODIFY
      IMPORTING keys FOR ACTION PurchaseReq~RejectPR RESULT result.

    METHODS SubmitPR FOR MODIFY
      IMPORTING keys FOR ACTION PurchaseReq~SubmitPR RESULT result.

    METHODS CalculateTotalAmount FOR DETERMINE ON MODIFY
      IMPORTING keys FOR PurchaseReq~CalculateTotalAmount.

    METHODS SetInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR PurchaseReq~SetInitialStatus.

    METHODS ValidatePRitems FOR VALIDATE ON SAVE
      IMPORTING keys FOR PurchaseReq~ValidatePRitems.

    METHODS ValidateTotalAmount FOR VALIDATE ON SAVE
      IMPORTING keys FOR PurchaseReq~ValidateTotalAmount.

ENDCLASS.

CLASS lhc_PurchaseReq IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD ApprovePR.
   MODIFY ENTITIES OF ZI_TH_PURCHASE_REQ IN LOCAL MODE
               ENTITY PurchaseReq
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR key IN keys
              (
               %tky = key-%tky
               Status = 'APPROVED'
              )
        ).

    READ ENTITIES OF ZI_TH_PURCHASE_REQ IN LOCAL MODE
                ENTITY PurchaseReq
                FIELDS ( Status )
                WITH CORRESPONDING #( keys )
                RESULT DATA(lt_result).

    result = VALUE #( FOR ls_result IN lt_result
                   (
                    %tky = ls_result-%tky
                    %param = ls_result
                   )
                 ).
  ENDMETHOD.

  METHOD CreatePO.

     DATA lv_po_id TYPE sysuuid_x16.

     LOOP AT keys INTO DATA(key).

      TRY.
       lv_po_id = cl_system_uuid=>create_uuid_x16_static(  ).
       CATCH CX_UUID_ERROR.
       ENDTRY.

*    INSERT zth_purch_order FROM VALUE #(
*      po_id          = lv_po_id
*      pr_id          = key-PurchaseReqId
*      status         = 'CREATED'
*      po_date        = cl_abap_context_info=>get_system_date( )
*    ).

     ENDLOOP.
  ENDMETHOD.

  METHOD RejectPR.
           MODIFY ENTITIES OF ZI_TH_PURCHASE_REQ IN LOCAL MODE
               ENTITY PurchaseReq
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR key IN keys
              (
               %tky = key-%tky
               Status = 'REJECTED'
              )
        ).

    READ ENTITIES OF ZI_TH_PURCHASE_REQ IN LOCAL MODE
                ENTITY PurchaseReq
                FIELDS ( Status )
                WITH CORRESPONDING #( keys )
                RESULT DATA(lt_result).

    result = VALUE #( FOR ls_result IN lt_result
                   (
                    %tky = ls_result-%tky
                    %param = ls_result
                   )
                 ).
  ENDMETHOD.

  METHOD SubmitPR.
         MODIFY ENTITIES OF ZI_TH_PURCHASE_REQ IN LOCAL MODE
               ENTITY PurchaseReq
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR key IN keys
              (
               %tky = key-%tky
               Status = 'SUBMITTED'
              )
        ).

    READ ENTITIES OF ZI_TH_PURCHASE_REQ IN LOCAL MODE
                ENTITY PurchaseReq
                FIELDS ( Status )
                WITH CORRESPONDING #( keys )
                RESULT DATA(lt_result).

    result = VALUE #( FOR ls_result IN lt_result
                   (
                    %tky = ls_result-%tky
                    %param = ls_result
                   )
                 ).
  ENDMETHOD.

  METHOD CalculateTotalAmount.
      READ ENTITIES OF ZI_TH_PURCHASE_REQ IN LOCAL MODE
                ENTITY PurchaseReq BY \_item
                ALL FIELDS
                WITH CORRESPONDING #( keys )
                RESULT DATA(items).

      DATA lv_total TYPE p LENGTH 10 DECIMALS 2.

      LOOP AT items INTO DATA(item).
         lv_total = lv_total + item-NetAmount.
      ENDLOOP.

      MODIFY ENTITIES OF ZI_TH_PURCHASE_REQ IN LOCAL MODE
                    ENTITY PurchaseReq
                    UPDATE FIELDS ( TotalAmount )
                    WITH VALUE #( FOR PurchaseReq IN keys
                               (
                                %tky = PurchaseReq-%tky
                                TotalAmount = lv_total
                               )
                           ).
  ENDMETHOD.

  METHOD SetInitialStatus.

    MODIFY ENTITIES OF ZI_TH_PURCHASE_REQ IN LOCAL MODE
                ENTITY PurchaseReq
                UPDATE FIELDS ( Status )
                WITH VALUE #( FOR PurchaseReq IN keys
                  (
                   %tky = purchasereq-%tky
                   Status = 'DRAFT'
                  )
                ).
  ENDMETHOD.

  METHOD ValidatePRitems.
     READ ENTITIES OF ZI_TH_PURCHASE_REQ IN LOCAL MODE
                 ENTITY PurchaseReq
                 ALL FIELDS
                 WITH CORRESPONDING #( keys )
                 RESULT DATA(items).

     LOOP AT items INTO DATA(item).
       IF items IS INITIAL.
         APPEND VALUE #(
              %tky = item-%tky
              %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'Purchase requisition require atleast one item'
              )
         ) TO reported-purchasereq.

       ENDIF.
     ENDLOOP.

  ENDMETHOD.

  METHOD ValidateTotalAmount.
      READ ENTITIES OF ZI_TH_PURCHASE_REQ IN LOCAL MODE
                ENTITY PurchaseReq
                ALL FIELDS
                WITH CORRESPONDING #( keys )
                RESULT DATA(lt_PurchReqs).

      LOOP AT lt_PurchReqs INTO DATA(lt_PurchReq).
         IF lt_PurchReq-TotalAmount IS INITIAL.
           APPEND VALUE #(
                  %tky  = lt_PurchReq-%tky
                  %msg  = new_message_with_text(
                                     severity = if_abap_behv_message=>severity-error
                                     text     = 'Total amount field does not have data'
                  )
            ) TO reported-PurchaseReq.
         ENDIF.
      ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_PurchaseReqItem DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS CalculateItemAmount FOR DETERMINE ON MODIFY
      IMPORTING keys FOR PurchaseReqItem~CalculateItemAmount.

    METHODS ValidateQuantity FOR VALIDATE ON SAVE
      IMPORTING keys FOR PurchaseReqItem~ValidateQuantity.

ENDCLASS.

CLASS lhc_PurchaseReqItem IMPLEMENTATION.

  METHOD CalculateItemAmount.

    READ ENTITIES OF ZI_TH_PURCHASE_REQ IN LOCAL MODE
              ENTITY PurchaseReq BY \_item
              ALL FIELDS
              WITH CORRESPONDING #( keys )
              RESULT DATA(items).

    LOOP AT items INTO DATA(item).

      MODIFY ENTITIES OF ZI_TH_PURCHASE_REQ IN LOCAL MODE
                   ENTITY PurchaseReqItem
                   UPDATE FIELDS ( NetAmount )
                   WITH VALUE #( FOR PurchaseReqItem IN items
                             (
                              %tky = PurchaseReqItem-%tky
                              NetAmount = item-Quantity * item-UnitPrice
                             )
                   ).
    ENDLOOP.
  ENDMETHOD.

  METHOD ValidateQuantity.

    READ ENTITIES OF ZI_TH_PURCHASE_REQ IN LOCAL MODE
              ENTITY PurchaseReq BY \_item
              FIELDS ( Quantity )
              WITH CORRESPONDING #( keys )
              RESULT DATA(items).

    LOOP AT items INTO DATA(item).
      IF item-Quantity IS INITIAL OR item-Quantity <= 0.
         APPEND VALUE #(
                   %tky = item-%tky
                   %msg = new_message_with_text(
                                   severity = if_abap_behv_message=>severity-error
                                   text     = 'Quality needs to be more than 0 or greater.'
                   )
         ) TO reported-purchasereqitem.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
