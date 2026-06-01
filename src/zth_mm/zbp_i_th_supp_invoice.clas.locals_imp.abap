CLASS lhc_ZI_TH_SUPP_INVOICE DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR SuppInvoice RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR SuppInvoice RESULT result.

    METHODS PayInvoice FOR MODIFY
      IMPORTING keys FOR ACTION SuppInvoice~PayInvoice RESULT result.

    METHODS PostInvoice FOR MODIFY
      IMPORTING keys FOR ACTION SuppInvoice~PostInvoice RESULT result.

    METHODS ReverseInvoice FOR MODIFY
      IMPORTING keys FOR ACTION SuppInvoice~ReverseInvoice RESULT result.

ENDCLASS.

CLASS lhc_ZI_TH_SUPP_INVOICE IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD PayInvoice.
     MODIFY ENTITIES OF ZI_TH_SUPP_INVOICE IN LOCAL MODE
                 ENTITY SuppInvoice
                 UPDATE FIELDS ( Status )
                 WITH VALUE #( FOR key IN keys
                             (
                              %tky = key-%tky
                              Status = 'PAID'
                             )
                            ).
      READ ENTITIES OF ZI_TH_SUPP_INVOICE IN LOCAL MODE
                ENTITY SuppInvoice
                FIELDS ( Status )
                WITH CORRESPONDING #( keys )
                RESULT DATA(lt_invoices).

      result = VALUE #( FOR ls_invoice IN lt_invoices
                       (
                        %tky = ls_invoice-%tky
                        %param = ls_invoice
                       )
                    ).
  ENDMETHOD.

  METHOD PostInvoice.
          MODIFY ENTITIES OF ZI_TH_SUPP_INVOICE IN LOCAL MODE
                 ENTITY SuppInvoice
                 UPDATE FIELDS ( Status )
                 WITH VALUE #( FOR key IN keys
                             (
                              %tky = key-%tky
                              Status = 'POSTED'
                             )
                            ).
      READ ENTITIES OF ZI_TH_SUPP_INVOICE IN LOCAL MODE
                ENTITY SuppInvoice
                FIELDS ( Status )
                WITH CORRESPONDING #( keys )
                RESULT DATA(lt_invoices).

      result = VALUE #( FOR ls_invoice IN lt_invoices
                       (
                        %tky = ls_invoice-%tky
                        %param = ls_invoice
                       )
                    ).
  ENDMETHOD.

  METHOD ReverseInvoice.
       MODIFY ENTITIES OF ZI_TH_SUPP_INVOICE IN LOCAL MODE
                 ENTITY SuppInvoice
                 UPDATE FIELDS ( Status )
                 WITH VALUE #( FOR key IN keys
                             (
                              %tky = key-%tky
                              Status = 'REVERSED'
                             )
                            ).
      READ ENTITIES OF ZI_TH_SUPP_INVOICE IN LOCAL MODE
                ENTITY SuppInvoice
                FIELDS ( Status )
                WITH CORRESPONDING #( keys )
                RESULT DATA(lt_invoices).

      result = VALUE #( FOR ls_invoice IN lt_invoices
                       (
                        %tky = ls_invoice-%tky
                        %param = ls_invoice
                       )
                    ).
  ENDMETHOD.

ENDCLASS.
