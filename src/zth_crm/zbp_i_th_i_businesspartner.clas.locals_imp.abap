CLASS lhc_ZI_TH_I_BusinessPartner DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR BusinessPartner RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR BusinessPartner RESULT result.

    METHODS setCreatedAndChanged FOR DETERMINE ON MODIFY
      IMPORTING keys FOR BusinessPartner~setCreatedAndChanged.

    METHODS validateEmail FOR VALIDATE ON SAVE
      IMPORTING keys FOR BusinessPartner~validateEmail.

ENDCLASS.

CLASS lhc_ZI_TH_I_BusinessPartner IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD setCreatedAndChanged.
       DATA(lv_user)  = cl_abap_context_info=>get_user_technical_name(  ).
       DATA(lv_time) = cl_abap_context_info=>get_system_time(  ).

       MODIFY ENTITIES OF ZI_TH_I_BUSINESSPARTNER IN LOCAL MODE
                     ENTITY BusinessPartner
                     UPDATE FIELDS ( CreatedBy CreatedAt LastChangedBy LastChangedAt LocalLastChangedAt )
                     WITH VALUE #( FOR key IN keys
                                  (
                                   %tky = key-%tky
                                   CreatedBy = lv_user
                                   CreatedAt = lv_time
                                   LastChangedBy = lv_user
                                   LastChangedAt = lv_time
                                   LocalLastChangedAt = lv_time
                                  )
                                ).
  ENDMETHOD.

  METHOD validateEmail.

       READ ENTITIES OF ZI_TH_I_BUSINESSPARTNER IN LOCAL MODE
                   ENTITY BusinessPartner
                   FIELDS ( Email )
                   WITH CORRESPONDING #( keys )
                   RESULT DATA(details).


       LOOP AT details INTO DATA(detail).
          IF detail-Email IS INITIAL.
           APPEND VALUE #( %tky = detail-%tky ) TO failed-businesspartner.
           APPEND VALUE #(
                           %tky = detail-%tky
                           %element-Email = if_abap_behv=>mk-on
                           %msg = new_message_with_text(
                                                       severity = if_abap_behv_message=>severity-error
                                                       text     = 'Email must be included'
                                                       )
                                                     ) TO reported-businesspartner.
              CONTINUE.
          ENDIF.

          DATA(lo_matcher) = cl_abap_matcher=>create(
                                                   pattern = '^[A-Za-z0-9,_%+-]+@[A-Za-z0-9,-]+\.[A-Za-z]{2,}$'
                                                   text    = detail-Email ).

          IF lo_matcher->match(  ) = abap_false.
             APPEND VALUE #( %tky = detail-%tky ) TO failed-businesspartner.
             APPEND VALUE #(
                             %tky = detail-%tky
                             %element-Email = if_abap_behv=>mk-on
                             %msg = new_message_with_text(
                                                          severity = if_abap_behv_message=>severity-error
                                                          text     = 'Invalid email format'
                                                          )
                                                      ) TO reported-businesspartner.
          ENDIF.
       ENDLOOP.

  ENDMETHOD.

ENDCLASS.
