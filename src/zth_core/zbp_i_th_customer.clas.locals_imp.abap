CLASS lhc_ZI_TH_CUSTOMER DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Customer RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Customer RESULT result.

    METHODS activatecustomer FOR MODIFY
      IMPORTING keys FOR ACTION Customer~activatecustomer RESULT result.

    METHODS blockcustomer FOR MODIFY
      IMPORTING keys FOR ACTION Customer~blockcustomer RESULT result.

    METHODS deactivatecustomer FOR MODIFY
      IMPORTING keys FOR ACTION Customer~deactivatecustomer RESULT result.

    METHODS setvipcusomer FOR MODIFY
      IMPORTING keys FOR ACTION Customer~setvipcustomer RESULT result.

    METHODS normalizecustomerdata FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Customer~normalizecustomerdata.

    METHODS setinitialstatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Customer~setinitialstatus.

    METHODS validatecountrycode FOR VALIDATE ON SAVE
      IMPORTING keys FOR Customer~validatecountrycode.

    METHODS validateemail FOR VALIDATE ON SAVE
      IMPORTING keys FOR Customer~validateemail.

    METHODS validatemandatorynames FOR VALIDATE ON SAVE
      IMPORTING keys FOR Customer~validatemandatorynames.

    METHODS validatephonenumber FOR VALIDATE ON SAVE
      IMPORTING keys FOR Customer~validatephonenumber.

    METHODS validatestatustransition FOR VALIDATE ON SAVE
      IMPORTING keys FOR Customer~validatestatustransition.

ENDCLASS.

CLASS lhc_ZI_TH_CUSTOMER IMPLEMENTATION.

  METHOD get_instance_authorizations.
    READ ENTITIES OF zi_th_customer IN LOCAL MODE
    ENTITY Customer
    FIELDS ( Status )
    WITH CORRESPONDING #( keys )
    RESULT DATA(customers).

  LOOP AT customers INTO DATA(customer).

    APPEND VALUE #(

      %tky = customer-%tky

      %update =
        COND #(
          WHEN customer-Status = 'BLOCKED'
          THEN if_abap_behv=>auth-unauthorized
          ELSE if_abap_behv=>auth-allowed
        )

      %delete =
        COND #(
          WHEN customer-Status = 'VIP'
          THEN if_abap_behv=>auth-unauthorized
          ELSE if_abap_behv=>auth-allowed
        )

      %action-ActivateCustomer =
        COND #(
          WHEN customer-Status = 'ACTIVE'
          THEN if_abap_behv=>auth-unauthorized
          ELSE if_abap_behv=>auth-allowed
        )

      %action-BlockCustomer =
        COND #(
          WHEN customer-Status = 'BLOCKED'
          THEN if_abap_behv=>auth-unauthorized
          ELSE if_abap_behv=>auth-allowed
        )

      %action-SetVipCustomer =
        COND #(
          WHEN customer-Status = 'ACTIVE'
          THEN if_abap_behv=>auth-allowed
          ELSE if_abap_behv=>auth-unauthorized
        )

      %action-DeactivateCustomer =
        COND #(
          WHEN customer-Status = 'ACTIVE'
             OR customer-Status = 'VIP'
          THEN if_abap_behv=>auth-allowed
          ELSE if_abap_behv=>auth-unauthorized
        )

    ) TO result.

  ENDLOOP.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD ActivateCustomer.
    MODIFY ENTITIES OF zi_th_customer IN LOCAL MODE
    ENTITY Customer
    UPDATE
    FIELDS ( Status )
    WITH VALUE #(
      FOR key IN keys
      (
        %tky   = key-%tky
        Status = 'ACTIVE'
      )
    ).

  READ ENTITIES OF zi_th_customer IN LOCAL MODE
    ENTITY Customer
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(customers).

  result = VALUE #(
    FOR customer IN customers
    (
      %tky   = customer-%tky
      %param = customer
    )
  ).
  ENDMETHOD.

  METHOD BlockCustomer.
      MODIFY ENTITIES OF zi_th_customer IN LOCAL MODE
    ENTITY Customer
    UPDATE
    FIELDS ( Status )
    WITH VALUE #(
      FOR key IN keys
      (
        %tky   = key-%tky
        Status = 'BLOCKED'
      )
    ).
  ENDMETHOD.

  METHOD DeactivateCustomer.
      READ ENTITIES OF zi_th_customer IN LOCAL MODE
    ENTITY Customer
    FIELDS ( Status )
    WITH CORRESPONDING #( keys )
    RESULT DATA(customers).

  LOOP AT customers INTO DATA(customer).

    IF customer-Status = 'ACTIVE'
       OR customer-Status = 'VIP'.

      MODIFY ENTITIES OF zi_th_customer IN LOCAL MODE
        ENTITY Customer
        UPDATE
        FIELDS ( Status )
        WITH VALUE #(
          (
            %tky   = customer-%tky
            Status = 'INACTIVE'
          )
        ).

    ELSE.

      APPEND VALUE #(
        %tky = customer-%tky
      ) TO failed-customer.

      APPEND VALUE #(
        %tky = customer-%tky
        %msg = new_message(
                 id       = 'ZTH_MSG'
                 number   = '005'
                 severity = if_abap_behv_message=>severity-error
                 v1       = |Customer cannot be deactivated from status { customer-Status }|
               )
      ) TO reported-customer.

    ENDIF.

  ENDLOOP.

  READ ENTITIES OF zi_th_customer IN LOCAL MODE
    ENTITY Customer
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(updated_customers).

  result = VALUE #(
    FOR updated_customer IN updated_customers
    (
      %tky   = updated_customer-%tky
      %param = updated_customer
    )
  ).

  ENDMETHOD.

  METHOD SetVIPCusomer.
     MODIFY ENTITIES OF zi_th_customer IN LOCAL MODE
    ENTITY Customer
    UPDATE
    FIELDS ( Status )
    WITH VALUE #(
      FOR key IN keys
      (
        %tky   = key-%tky
        Status = 'VIP'
      )
    ).
  ENDMETHOD.

  METHOD NormalizeCustomerData.
      READ ENTITIES OF zi_th_customer IN LOCAL MODE
    ENTITY Customer
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(customers).

  MODIFY ENTITIES OF zi_th_customer IN LOCAL MODE
    ENTITY Customer
    UPDATE
    FIELDS ( FirstName
             LastName
             Email
             CountryCode )
    WITH VALUE #(

      FOR customer IN customers
      (

        %tky = customer-%tky

        FirstName =
          to_mixed(
            val = condense( customer-FirstName )
          )

        LastName =
          to_mixed(
            val = condense( customer-LastName )
          )

        Email =
          to_lower(
            condense( customer-Email )
          )

        CountryCode =
          to_upper(
            condense( customer-CountryCode )
          )

      )

    ).
  ENDMETHOD.

  METHOD SetInitialStatus.
      MODIFY ENTITIES OF zi_th_customer IN LOCAL MODE
    ENTITY Customer
    UPDATE
    FIELDS ( Status )
    WITH VALUE #(
      FOR key IN keys
      (
        %tky   = key-%tky
        Status = 'NEW'
      )
    ).
  ENDMETHOD.

  METHOD ValidateCountryCode.
      READ ENTITIES OF zi_th_customer IN LOCAL MODE
    ENTITY Customer
    FIELDS ( CountryCode )
    WITH CORRESPONDING #( keys )
    RESULT DATA(customers).

  LOOP AT customers INTO DATA(customer).

    IF strlen( customer-CountryCode ) < 2.

      APPEND VALUE #(
        %tky = customer-%tky
      ) TO failed-customer.

      APPEND VALUE #(
        %tky = customer-%tky
        %msg = new_message(
                 id       = 'ZTH_MSG'
                 number   = '004'
                 severity = if_abap_behv_message=>severity-error
                 v1       = 'Invalid Country Code'
               )
      ) TO reported-customer.

    ENDIF.

  ENDLOOP.
  ENDMETHOD.

  METHOD ValidateEmail.
    READ ENTITIES OF zi_th_customer IN LOCAL MODE
    ENTITY Customer
    FIELDS ( Email )
    WITH CORRESPONDING #( keys )
    RESULT DATA(customers).

  LOOP AT customers INTO DATA(customer).

    IF customer-Email IS INITIAL
       OR customer-Email NS '@'
       OR customer-Email NS '.'.

      APPEND VALUE #(
        %tky = customer-%tky
      ) TO failed-customer.

      APPEND VALUE #(
        %tky = customer-%tky
        %msg = new_message(
                 id       = 'ZTH_MSG'
                 number   = '001'
                 severity = if_abap_behv_message=>severity-error
                 v1       = 'Invalid Email Address'
               )
      ) TO reported-customer.

    ENDIF.

  ENDLOOP.
  ENDMETHOD.

  METHOD ValidateMandatoryNames.
    READ ENTITIES OF zi_th_customer IN LOCAL MODE
    ENTITY Customer
    FIELDS ( FirstName LastName )
    WITH CORRESPONDING #( keys )
    RESULT DATA(customers).

  LOOP AT customers INTO DATA(customer).

    IF customer-FirstName IS INITIAL
       OR customer-LastName IS INITIAL.

      APPEND VALUE #(
        %tky = customer-%tky
      ) TO failed-customer.

      APPEND VALUE #(
        %tky = customer-%tky
        %msg = new_message(
                 id       = 'ZTH_MSG'
                 number   = '002'
                 severity = if_abap_behv_message=>severity-error
                 v1       = 'First Name and Last Name are required'
               )
      ) TO reported-customer.

    ENDIF.

  ENDLOOP.
  ENDMETHOD.

  METHOD ValidatePhoneNumber.
    READ ENTITIES OF zi_th_customer IN LOCAL MODE
    ENTITY Customer
    FIELDS ( PhoneNumber )
    WITH CORRESPONDING #( keys )
    RESULT DATA(customers).

  LOOP AT customers INTO DATA(customer).

    IF strlen( customer-PhoneNumber ) < 8.

      APPEND VALUE #(
        %tky = customer-%tky
      ) TO failed-customer.

      APPEND VALUE #(
        %tky = customer-%tky
        %msg = new_message(
                 id       = 'ZTH_MSG'
                 number   = '003'
                 severity = if_abap_behv_message=>severity-error
                 v1       = 'Phone Number too short'
               )
      ) TO reported-customer.

    ENDIF.

  ENDLOOP.
  ENDMETHOD.

  METHOD ValidateStatusTransition.
    READ ENTITIES OF zi_th_customer IN LOCAL MODE
    ENTITY Customer
    FIELDS ( Status )
    WITH CORRESPONDING #( keys )
    RESULT DATA(customers).

  LOOP AT customers INTO DATA(customer).

    DATA(lv_invalid_transition) = abap_false.

    CASE customer-Status.

      WHEN 'VIP'.

        " VIP should only come from ACTIVE
        lv_invalid_transition = abap_false.

      WHEN 'INACTIVE'.

        " INACTIVE should only come from ACTIVE or VIP
        lv_invalid_transition = abap_false.

      WHEN 'BLOCKED'.

        " BLOCKED should only come from ACTIVE or VIP
        lv_invalid_transition = abap_false.

      WHEN 'ACTIVE'.

        " ACTIVE allowed
        lv_invalid_transition = abap_false.

      WHEN 'NEW'.

        " NEW only allowed during creation
        lv_invalid_transition = abap_false.

      WHEN OTHERS.

        lv_invalid_transition = abap_true.

    ENDCASE.

    IF lv_invalid_transition = abap_true.

      APPEND VALUE #(
        %tky = customer-%tky
      ) TO failed-customer.

      APPEND VALUE #(
        %tky = customer-%tky
        %msg = new_message(
                 id       = 'ZTH_MSG'
                 number   = '006'
                 severity = if_abap_behv_message=>severity-error
                 v1       = |Invalid status transition|
               )
      ) TO reported-customer.

    ENDIF.

  ENDLOOP.
  ENDMETHOD.

ENDCLASS.
