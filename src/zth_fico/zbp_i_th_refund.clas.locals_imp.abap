CLASS lhc_ZI_TH_REFUND DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR refund RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR refund RESULT result.

    METHODS approveRefund FOR MODIFY
      IMPORTING keys FOR ACTION refund~approveRefund RESULT result.

    METHODS rejectRefund FOR MODIFY
      IMPORTING keys FOR ACTION refund~rejectRefund RESULT result.

    METHODS submitRefund FOR MODIFY
      IMPORTING keys FOR ACTION refund~submitRefund RESULT result.

    METHODS SetInitialRefundStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR refund~SetInitialRefundStatus.

    METHODS validateRefundAmount FOR VALIDATE ON SAVE
      IMPORTING keys FOR refund~validateRefundAmount.

ENDCLASS.

CLASS lhc_ZI_TH_REFUND IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD approveRefund.

     READ ENTITIES OF ZI_TH_REFUND IN LOCAL MODE
              ENTITY Refund
              FIELDS ( Status )
              WITH CORRESPONDING #( keys )
              RESULT DATA(refunds_list).

     LOOP AT refunds_list ASSIGNING FIELD-SYMBOL(<refund_list>).
        IF <refund_list>-Status <> 'SUBMITTED'.
          APPEND VALUE #(
               %tky = <refund_list>-%tky
               %msg = new_message_with_text(
                              severity = if_abap_behv_message=>severity-error
                              text     = 'Only SUBMITTED events can be approved'
               )
          ) TO reported-refund.

         APPEND VALUE #( %tky = <refund_list>-%tky ) TO failed-refund.

         CONTINUE.
        ENDIF.

        MODIFY ENTITIES OF ZI_TH_REFUND IN LOCAL MODE
                    ENTITY refund
                    UPDATE FIELDS ( Status )
                    WITH VALUE #( FOR refund IN refunds_list
                         (
                          %tky       = <refund_list>-%tky
                          Status     = 'APPROVED'
                          ApprovedBy = sy-uname
                          ApprovedAt = cl_abap_context_info=>get_system_time( )
                         )
                     ).

          result = VALUE #( FOR refund IN refunds_list
                 (
                    %tky = <refund_list>-%tky
                    %param = refund
                 )
          ).
     ENDLOOP.
  ENDMETHOD.

  METHOD rejectRefund.
      READ ENTITIES OF ZI_TH_REFUND IN LOCAL MODE
                ENTITY Refund
                ALL FIELDS
                WITH CORRESPONDING #( keys )
                RESULT DATA(refunds_list).

      LOOP AT refunds_list INTO DATA(refund_list).
         IF refund_list-Status <> 'SUBMITTED'.
          APPEND VALUE #(
             %tky = refund_list-%tky
             %msg = new_message_with_text(
                                   severity = if_abap_behv_message=>severity-error
                                   text     = 'Refund must be SUBMITTED before rejection'
              )
          ) TO reported-refund.
          APPEND VALUE #( %tky = refund_list-%tky ) TO failed-refund.
          CONTINUE.
         ENDIF.
      ENDLOOP.

      MODIFY ENTITIES OF ZI_TH_REFUND IN LOCAL MODE
                   ENTITY Refund
                   UPDATE FIELDS ( Status  )
                   WITH VALUE #( FOR refund IN refunds_list
                        (
                         %tky = refund-%tky
                         Status = 'REJECTED'
                         ApprovedBy = sy-uname
                         ApprovedAt = cl_abap_context_info=>get_system_time(  )
                        )
                   ).
      result = VALUE #(
            FOR refund IN refunds_list
            (
             %tky = refund_list-%tky
             %param = refund
            )
       ).

  ENDMETHOD.

  METHOD submitRefund.

     READ ENTITIES OF ZI_TH_REFUND IN LOCAL MODE
                ENTITY Refund
            ALL FIELDS
            WITH CORRESPONDING #( keys )
            RESULT DATA(lt_refunds).

    LOOP AT lt_refunds INTO DATA(lt_refund).
        IF lt_refund-Status <> 'DRAFT'.
          APPEND VALUE #(
            %tky = lt_refund-%tky
            %msg = new_message_with_text(
                                severity = if_abap_behv_message=>severity-error
                                text     = 'Only DRAFT event can be submmited'
            )
          ) TO reported-refund.
          APPEND VALUE #( %tky = lt_refund-%tky ) TO failed-refund.

        CONTINUE.
        ENDIF.

    ENDLOOP.

    MODIFY ENTITIES OF ZI_TH_REFUND IN LOCAL MODE
                ENTITY Refund
                UPDATE FIELDS ( Status )
                WITH VALUE #( FOR refund IN lt_refunds
                        (
                         %tky       = lt_refund-%tky
                         Status     = 'SUBMITTED'
                         ApprovedBy = sy-uname
                         ApprovedAt = cl_abap_context_info=>get_system_time(  )
                        )
                ).

      result = VALUE #( FOR refund IN lt_refunds
                 (
                   %tky   = lt_refund-%tky
                   %param = refund
                 )
      ).

  ENDMETHOD.

  METHOD SetInitialRefundStatus.

   MODIFY ENTITIES OF ZI_TH_REFUND IN LOCAL MODE
               ENTITY Refund
               UPDATE FIELDS ( Status )
               WITH VALUE #( FOR refund IN keys
                  (
                   %tky   = refund-%tky
                   Status = 'DRAFT'
                  )
               ).
  ENDMETHOD.

  METHOD validateRefundAmount.

     READ ENTITIES OF ZI_TH_REFUND IN LOCAL MODE
                ENTITY Refund
                FIELDS ( Status )
                WITH CORRESPONDING #( keys )
                RESULT DATA(lt_refunds).

    LOOP AT lt_refunds INTO DATA(lt_refund).
      IF lt_refund-RefundAmount <= 0.
        APPEND VALUE #(
         %tky = lt_refund-%tky
         %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text    = 'Refund amount must be greater than 0.'
         )
        ) TO reported-refund.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
