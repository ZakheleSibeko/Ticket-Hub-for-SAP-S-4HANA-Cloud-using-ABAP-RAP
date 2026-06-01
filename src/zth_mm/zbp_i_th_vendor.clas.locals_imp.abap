CLASS lhc_ZI_TH_VENDOR DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR vendor RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR vendor RESULT result.

    METHODS ActivateVendor FOR MODIFY
      IMPORTING keys FOR ACTION Vendor~ActivateVendor RESULT result.

    METHODS DeleteVendor FOR MODIFY
      IMPORTING keys FOR ACTION Vendor~DeleteVendor RESULT result.

    METHODS RegisterVendor FOR MODIFY
      IMPORTING keys FOR ACTION Vendor~RegisterVendor RESULT result.

    METHODS SetInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Vendor~SetInitialStatus.

    METHODS ValidateVendorStatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR Vendor~ValidateVendorStatus.

    METHODS ValidateVendorDetails FOR VALIDATE ON SAVE
      IMPORTING keys FOR Vendor~ValidateVendorDetails.

ENDCLASS.

CLASS lhc_ZI_TH_VENDOR IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD ActivateVendor.

    MODIFY ENTITIES OF ZI_TH_VENDOR IN LOCAL MODE
                ENTITY Vendor
                UPDATE FIELDS ( Status )
                WITH VALUE #( FOR key IN keys
                    (
                     %tky = key-%tky
                     Status = 'Active'
                    )
                ).
   READ ENTITIES OF ZI_TH_VENDOR IN LOCAL MODE
                     ENTITY Vendor
                     FIELDS ( Status )
                     WITH CORRESPONDING #( keys )
                     RESULT DATA(lt_results).

   result = VALUE #(
              FOR ls_result IN lt_results
               (
                %tky = ls_result-%tky
                %param = ls_result
               )
         ).

  ENDMETHOD.

  METHOD DeleteVendor.

     MODIFY ENTITIES OF ZI_TH_VENDOR IN LOCAL MODE
                 ENTITY Vendor
                 UPDATE FIELDS ( Status )
                 WITH VALUE #( FOR key IN keys
                      (
                       %tky = key-%tky
                       Status = 'Deleted'
                      )
                 ).
    READ ENTITIES OF ZI_TH_VENDOR IN LOCAL MODE
                     ENTITY Vendor
                     FIELDS ( Status )
                     WITH CORRESPONDING #( keys )
                     RESULT DATA(lt_results).

     result = VALUE #(
              FOR ls_result IN lt_results
               (
                %tky = ls_result-%tky
                %param = ls_result
               )
         ).

  ENDMETHOD.

  METHOD RegisterVendor.

    MODIFY ENTITIES OF ZI_TH_VENDOR IN LOCAL MODE
                ENTITY Vendor
                UPDATE FIELDS ( Status )
                WITH VALUE #( FOR key IN keys
                           (
                            %tky = key-%tky
                            Status = 'Registered'
                           )
                        ).
    READ ENTITIES OF ZI_TH_VENDOR IN LOCAL MODE
                ENTITY Vendor
                ALL FIELDS
                WITH CORRESPONDING #( keys )
                RESULT DATA(lt_results).

    result = VALUE #( FOR ls_result IN lt_results
               (
                %tky = ls_result-%tky
                %param = ls_result
               )
    ).

  ENDMETHOD.

  METHOD SetInitialStatus.

         MODIFY ENTITIES OF ZI_TH_VENDOR IN LOCAL MODE
                      ENTITY Vendor
                      UPDATE FIELDS ( Status )
                      WITH VALUE #( FOR key IN keys
                                 (
                                  %tky = key-%tky
                                  Status = 'DRAFT'
                                 )
                                ).
  ENDMETHOD.

  METHOD ValidateVendorStatus.
        READ ENTITIES OF ZI_TH_VENDOR IN LOCAL MODE
                   ENTITY Vendor
                   ALL FIELDS
                   WITH CORRESPONDING #( keys )
                   RESULT DATA(lt_vendors).
        LOOP AT lt_vendors ASSIGNING FIELD-SYMBOL(<lt_vendor>).
          IF <lt_vendor>-Status <> 'DRAFT'.
            APPEND VALUE #(
                            %tky = <lt_vendor>-%tky
                            %msg = new_message_with_text(
                                                 severity = if_abap_behv_message=>severity-error
                                                 text     = 'Only vendors with DRAFT status can be validated '
                          )
                        ) TO reported-vendor.
             APPEND VALUE #( %tky = <lt_vendor>-%tky ) TO failed-vendor.
             CONTINUE.
          ENDIF.
        ENDLOOP.

  ENDMETHOD.

  METHOD ValidateVendorDetails.

      READ ENTITIES OF ZI_TH_VENDOR IN LOCAL MODE
                ENTITY Vendor
                ALL FIELDS
                WITH CORRESPONDING #( keys )
                RESULT DATA(lt_vendors).

      LOOP AT lt_vendors INTO DATA(lt_vendor).
        IF lt_vendor IS INITIAL OR lt_vendor-VendorId AND lt_vendor-VendorName IS INITIAL.
           APPEND VALUE #(
                   %tky = lt_vendor-%tky
                   %msg = new_message_with_text(
                                      severity = if_abap_behv_message=>severity-error
                                      text     = 'Only completed vendor information can be validated'
                                      )
           ) TO reported-vendor.
           APPEND VALUE #( %tky = lt_vendor-%tky ) TO failed-vendor.
           CONTINUE.
        ENDIF.


     ENDLOOP.
  ENDMETHOD.

ENDCLASS.
