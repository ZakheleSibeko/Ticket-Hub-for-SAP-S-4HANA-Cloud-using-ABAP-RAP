CLASS lhc_ZI_TH_VENDOR DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_th_vendor RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zi_th_vendor RESULT result.

    METHODS ActivateVendor FOR MODIFY
      IMPORTING keys FOR ACTION Vendor~ActivateVendor RESULT result.

    METHODS DeleteVendor FOR MODIFY
      IMPORTING keys FOR ACTION Vendor~DeleteVendor RESULT result.

    METHODS RegisterVendor FOR MODIFY
      IMPORTING keys FOR ACTION Vendor~RegisterVendor RESULT result.

    METHODS SetInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Vendor~SetInitialStatus.

    METHODS VaildateVendorStatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR Vendor~VaildateVendorStatus.

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
  ENDMETHOD.

  METHOD DeleteVendor.
     MODIFY ENTITIES OF ZI_TH_VENDOR IN LOCAL MODE
                 ENTITY Vendor
                 UPDATE FIELDS ( Status )
                 WITH VALUE #( FOR key IN keys
                      (
                       %tky = key-%tky
                       Status = 'DELETED'
                      )
                 ).
  ENDMETHOD.

  METHOD RegisterVendor.
  ENDMETHOD.

  METHOD SetInitialStatus.
  ENDMETHOD.

  METHOD VaildateVendorStatus.
  ENDMETHOD.

  METHOD ValidateVendorDetails.
  ENDMETHOD.

ENDCLASS.
