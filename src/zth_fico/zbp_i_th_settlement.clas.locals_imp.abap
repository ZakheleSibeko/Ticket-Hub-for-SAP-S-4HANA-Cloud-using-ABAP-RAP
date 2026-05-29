CLASS lhc_ZI_TH_SETTLEMENT DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Settlement RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Settlement RESULT result.

    METHODS GenerateSettlement FOR MODIFY
      IMPORTING keys FOR ACTION Settlement~GenerateSettlement RESULT result.

    METHODS setInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Settlement~setInitialStatus.

ENDCLASS.

CLASS lhc_ZI_TH_SETTLEMENT IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

METHOD generatesettlement.

  DATA:
    lv_revenue     TYPE p LENGTH 16 DECIMALS 2,
    lv_refund      TYPE p LENGTH 16 DECIMALS 2,
    lv_cost        TYPE p LENGTH 16 DECIMALS 2,
    lv_profit      TYPE p LENGTH 16 DECIMALS 2,
    lv_commission  TYPE p LENGTH 16 DECIMALS 2,
    lv_event_id    TYPE sysuuid_x16.

  CONSTANTS:
    lc_status_generated TYPE char20 VALUE 'GENERATED'.

  READ ENTITIES OF zi_th_settlement IN LOCAL MODE
    ENTITY Settlement
    FIELDS ( EventId )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_settlements).

  LOOP AT lt_settlements INTO DATA(ls_settlement).

    lv_event_id = ls_settlement-EventId.

    " Revenue
    SELECT SUM( net_amount )
      FROM zth_booking
      WHERE event_id = @lv_event_id
      INTO @lv_revenue.

    " Refunds
    SELECT SUM( refund_amount )
      FROM zth_refund
      WHERE booking_id IN (
        SELECT booking_id
        FROM zth_booking
        WHERE event_id = @lv_event_id
      )
      INTO @lv_refund.

    " Costs
    SELECT SUM( amount )
      FROM zth_event_cost
      WHERE event_id = @lv_event_id
      INTO @lv_cost.

    IF lv_revenue IS INITIAL.
      lv_revenue = 0.
    ENDIF.

    IF lv_refund IS INITIAL.
      lv_refund = 0.
    ENDIF.

    IF lv_cost IS INITIAL.
      lv_cost = 0.
    ENDIF.

    lv_commission = lv_revenue * '0.05'.

    lv_profit =
        lv_revenue
      - lv_refund
      - lv_cost
      - lv_commission.

    MODIFY ENTITIES OF zi_th_settlement IN LOCAL MODE
      ENTITY Settlement
      UPDATE FIELDS (
        GrossRevenue
        RefundAmount
        TotalCost
        PlatformCommission
        NetSettlement
        Status
      )
      WITH VALUE #(
        (
          %tky               = ls_settlement-%tky
          GrossRevenue       = lv_revenue
          RefundAmount       = lv_refund
          TotalCost          = lv_cost
          PlatformCommission = lv_commission
          NetSettlement      = lv_profit
          Status             = lc_status_generated
        )
      ).

  ENDLOOP.

ENDMETHOD.

  METHOD setInitialStatus.
    MODIFY ENTITIES OF zi_th_settlement IN LOCAL MODE
                ENTITY Settlement
                UPDATE FIELDS ( Status )
                WITH VALUE #( FOR key IN keys
                          (
                           %tky   = key-%tky
                           Status = 'NONE'
                          )
                      ).
  ENDMETHOD.

ENDCLASS.
