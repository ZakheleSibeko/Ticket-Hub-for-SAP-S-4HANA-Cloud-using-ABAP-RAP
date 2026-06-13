CLASS lhc_Event DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Event RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Event RESULT result.

    METHODS approveEvent FOR MODIFY
      IMPORTING keys FOR ACTION Event~approveEvent RESULT result.

    METHODS cancelEvent FOR MODIFY
      IMPORTING keys FOR ACTION Event~cancelEvent RESULT result.

    METHODS closeEvent FOR MODIFY
      IMPORTING keys FOR ACTION Event~closeEvent RESULT result.

    METHODS rejectEvent FOR MODIFY
      IMPORTING keys FOR ACTION Event~rejectEvent RESULT result.

    METHODS submitForApproval FOR MODIFY
      IMPORTING keys FOR ACTION Event~submitForApproval RESULT result.

    METHODS SetInitialEventValues FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Event~SetInitialEventValues.

    METHODS ValidateCapacity FOR VALIDATE ON SAVE
      IMPORTING keys FOR Event~ValidateCapacity.

    METHODS ValidateEventDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR Event~ValidateEventDates.

    METHODS ValidateEventReadiness FOR VALIDATE ON SAVE
      IMPORTING keys FOR Event~ValidateEventReadiness.

    METHODS ValidateEventText FOR VALIDATE ON SAVE
      IMPORTING keys FOR Event~ValidateEventText.
    METHODS SetInitialCurrency FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Event~SetInitialCurrency.
*    METHODS SetAdminFields FOR DETERMINE ON MODIFY
*      IMPORTING keys FOR Event~SetAdminFields.


ENDCLASS.

CLASS lhc_Event IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD approveEvent.

     READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
               ENTITY Event
               FIELDS ( EventId Status )
               WITH CORRESPONDING #( keys )
               RESULT DATA(events).

     LOOP AT events ASSIGNING FIELD-SYMBOL(<event>).
      IF <event>-Status <> 'SUBMITTED'.
        APPEND VALUE #( %tky = <event>-%tky ) TO failed-event.

        APPEND VALUE #(
                       %tky = <event>-%tky
                       %msg = new_message_with_text(
                                                     severity = if_abap_behv_message=>severity-error
                                                     text     = 'Only SUBMITTED events can be approved'
                    )
                   ) TO reported-event.

         CONTINUE.
      ENDIF.

      MODIFY ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
                   ENTITY Event
                   UPDATE FIELDS ( Status )
                   WITH VALUE #(
                      (
                        %tky = <event>-%tky
                        Status = 'APPROVED'
                      )
                   ).

     ENDLOOP.

     READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
               ENTITY Event
               ALL FIELDS
               WITH CORRESPONDING #( keys )
               RESULT DATA(updated_events).

     result = VALUE #( FOR event IN updated_events
             (
              %tky = <event>-%tky
              %param = event
             )
        ).

  ENDMETHOD.

  METHOD cancelEvent.

   READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
              ENTITY Event
              FIELDS ( EventId Status )
              WITH CORRESPONDING #( keys )
              RESULT DATA(events).

   LOOP AT events ASSIGNING FIELD-SYMBOL(<event>).
     IF <event>-Status   <> 'SUBMITTED'
      AND <event>-Status <> 'DRAFT'
      AND <event>-Status <> 'APPROVED'.

      APPEND VALUE #( %tky = <event>-%tky ) TO failed-event.

      APPEND VALUE #(
            %tky = <event>-%tky
            %msg = new_message_with_text(
                                         severity = if_abap_behv_message=>severity-error
                                         text     = 'Only DRAFT, SUBMITTED AND APPROVED events can be canceled'
            )
      ) TO reported-event.
      CONTINUE.
     ENDIF.

     MODIFY ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
                    ENTITY Event
                    UPDATE FIELDS ( Status )
                    WITH VALUE #(
                        (
                         %tky   = <event>-%tky
                         Status = 'CANCELED'
                        )
                    ).
   ENDLOOP.

     READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
                ENTITY Event
                ALL FIELDS
                WITH CORRESPONDING #( keys )
                RESULT DATA(updated_events).

     result = VALUE #( FOR event IN updated_events
               (
                %tky   = <event>-%tky
                %param = event
               )
       ).

  ENDMETHOD.

  METHOD closeEvent.

        READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
      ENTITY Event
      FIELDS ( EventId Status )
      WITH CORRESPONDING #( keys )
      RESULT DATA(events).

    LOOP AT events ASSIGNING FIELD-SYMBOL(<event>).

      IF <event>-Status <> 'APPROVED'.
        APPEND VALUE #( %tky = <event>-%tky ) TO failed-event.

        APPEND VALUE #(
          %tky = <event>-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Only APPROVED events can be closed.'
          )
        ) TO reported-event.

        CONTINUE.
      ENDIF.

      MODIFY ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
        ENTITY Event
        UPDATE FIELDS ( Status )
        WITH VALUE #(
          (
            %tky   = <event>-%tky
            Status = 'CLOSED'
          )
        ).

    ENDLOOP.

    READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
      ENTITY Event
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(updated_events).

    result = VALUE #( FOR event IN updated_events
      (
        %tky   = event-%tky
        %param = event
      )
    ).

  ENDMETHOD.

  METHOD rejectEvent.

    READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
              ENTITY Event
              FIELDS ( EventId Status )
              WITH CORRESPONDING #( keys )
              RESULT DATA(events).

    LOOP AT events ASSIGNING FIELD-SYMBOL(<event>).

       IF <event>-Status <> 'SUBMITTED'.
         APPEND VALUE #( %tky = <event>-%tky ) TO failed-event.

         APPEND VALUE #(
                 %tky = <event>-%tky
                 %msg = new_message_with_text(
                                              severity = if_abap_behv_message=>severity-error
                                              text     = 'Only SUBMITTED events can be rejected'
                 )
         ) TO reported-event.
         CONTINUE.
       ENDIF.

       MODIFY ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
                    ENTITY Event
                    UPDATE FIELDS ( Status )
                    WITH VALUE #(
                       (
                        %tky = <event>-%tky
                        Status = 'REJECTED'
                       )
                    ).
    ENDLOOP.

    READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
               ENTITY Event
               ALL FIELDS
               WITH CORRESPONDING #( keys )
               RESULT DATA(updated_events).

    result = VALUE #( FOR event IN updated_events
        (
          %tky = <event>-%tky
          %param = event
        )
    ).

  ENDMETHOD.

  METHOD submitForApproval.

    READ ENTITIES OF zi_th_event IN LOCAL MODE
              ENTITY Event
              FIELDS ( EventId Status )
              WITH CORRESPONDING #( keys )
              RESULT DATA(events).

    LOOP AT events ASSIGNING FIELD-SYMBOL(<event>).
      IF <event>-Status <> 'DRAFT'.
        APPEND VALUE #( %tky = <event>-%tky ) TO failed-event.

        APPEND VALUE #(
            %tky = <event>-%tky
            %msg = new_message_with_text(
                                           severity = if_abap_behv_message=>severity-error
                                           text     = 'Only DRAFT can be submitted for approval'
            )
         ) TO reported-event.
        CONTINUE.
      ENDIF.

      MODIFY ENTITIES OF zi_th_event IN LOCAL MODE
         ENTITY Event
         UPDATE FIELDS ( Status )
         WITH VALUE #(
                (
                 %tky = <event>-%tky
                 Status = 'SUBMITTED'
                )
          ).

    ENDLOOP.

    READ ENTITIES OF zi_th_event IN LOCAL MODE
               ENTITY Event
               ALL FIELDS
               WITH CORRESPONDING #( keys )
               RESULT DATA(updated_events).

    result = VALUE #( FOR event IN updated_events
                (
                 %tky   = event-%tky
                 %param = event
                )
        ).

  ENDMETHOD.

  METHOD SetInitialEventValues.

    READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
              ENTITY Event
              FIELDS ( EventId Status TotalCapacity AvailableCapacity )
              WITH CORRESPONDING #( keys )
              RESULT DATA(events).

    LOOP AT events ASSIGNING FIELD-SYMBOL(<event>).

       MODIFY ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
                   ENTITY Event
                   UPDATE FIELDS ( Status AvailableCapacity )
                   WITH VALUE #(
                       (
                        %tky = <event>-%tky
                        Status            = COND #( WHEN <event>-Status IS INITIAL THEN 'DRAFT'
                                                    ELSE <event>-Status )
                        AvailableCapacity = COND #( WHEN <event>-AvailableCapacity IS INITIAL
                                                    THEN <event>-TotalCapacity
                                                    ELSE <event>-AvailableCapacity )
                    )
                  ).

    ENDLOOP.

  ENDMETHOD.

  METHOD ValidateCapacity.

   READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
             ENTITY Event
             FIELDS ( EventId  TotalCapacity )
             WITH CORRESPONDING #( keys )
             RESULT DATA(events).

   LOOP AT events ASSIGNING FIELD-SYMBOL(<event>).
     IF <event>-TotalCapacity <= 0.
       APPEND VALUE #( %tky = <event>-%tky ) TO failed-event.
       APPEND VALUE #(
               %tky = <event>-%tky
               %element-TotalCapacity = if_abap_behv=>mk-on
               %msg = new_message_with_text(
                                        severity = if_abap_behv_message=>severity-error
                                        text     = 'Total capacity must be greater than zero'
                )
       ) TO reported-event.
     ENDIF.
   ENDLOOP.
  ENDMETHOD.

  METHOD ValidateEventDates.

    READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
               ENTITY Event
               FIELDS ( EventId StartDate EndDate )
               WITH CORRESPONDING #( keys )
               RESULT DATA(events).

    LOOP AT events ASSIGNING FIELD-SYMBOL(<event>).
      IF <event>-StartDate IS NOT INITIAL
       AND <event>-EndDate IS NOT INITIAL
       AND <event>-StartDate > <event>-EndDate.

         APPEND VALUE #( %tky = <event>-%tky ) TO failed-event.

         APPEND VALUE #(
                %tky = <event>-%tky
                %element-StartDate = if_abap_behv=>mk-on
                %element-Enddate   = if_abap_behv=>mk-on
                %msg  = new_message_with_text(
                                    severity = if_abap_behv_message=>severity-error
                                    text     = 'Start date must not be after end date'
                )
         ) TO reported-event.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD ValidateEventReadiness.

   READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
             ENTITY Event
             FIELDS ( EventId Status )
             WITH CORRESPONDING #( keys )
             RESULT DATA(events).

   LOOP AT events ASSIGNING FIELD-SYMBOL(<event>).

     IF <event>-Status = 'APPROVED'.

       SELECT COUNT( * )
       FROM zth_ticket_type
      WHERE event_id = @<event>-EventId
       AND  status  = 'ACTIVE'
       INTO @DATA(active_ticket_count).

       IF active_ticket_count = 0.
          APPEND VALUE #(
            %tky = <event>-%tky
            %msg = new_message_with_text(
              severity = if_abap_behv_message=>severity-error
              text     = 'Approved event must have at least one active ticket type.'
            )
          ) TO reported-event.
       ENDIF.

     ENDIF.

   ENDLOOP.

  ENDMETHOD.

  METHOD ValidateEventText.

       READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
      ENTITY Event
      FIELDS ( EventId EventName Venue )
      WITH CORRESPONDING #( keys )
      RESULT DATA(events).

    LOOP AT events ASSIGNING FIELD-SYMBOL(<event>).

      IF <event>-EventName IS INITIAL.

        APPEND VALUE #( %tky = <event>-%tky ) TO failed-event.

        APPEND VALUE #(
          %tky = <event>-%tky
          %element-EventName = if_abap_behv=>mk-on
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Event name must not be empty.'
          )
        ) TO reported-event.

      ENDIF.

      IF <event>-Venue IS INITIAL.

        APPEND VALUE #( %tky = <event>-%tky ) TO failed-event.

        APPEND VALUE #(
          %tky = <event>-%tky
          %element-Venue = if_abap_behv=>mk-on
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Venue must not be empty.'
          )
        ) TO reported-event.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD SetInitialCurrency.
    READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
              ENTITY Event
              FIELDS ( CurrencyCode )
              WITH CORRESPONDING #( keys )
              RESULT DATA(details).

    LOOP AT details INTO DATA(detail).
       MODIFY ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
                   ENTITY Event
                   UPDATE FIELDS ( CurrencyCode )
                   WITH VALUE #( FOR key IN details
                                (
                                 %tky = key-%tky
                                 CurrencyCode = 'ZAR'
                                )
                               ).
    ENDLOOP.
  ENDMETHOD.

*  METHOD SetAdminFields.
*      READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
*                 ENTITY Event
*                 FIELDS ( CreatedAt CreatedBy LastChangedAt LastChangedBy LocalLastChangedAt )
*                 WITH CORRESPONDING #( keys )
*                 RESULT DATA(details).
*
*      LOOP AT details INTO DATA(detail).
*        DATA(user) = cl_abap_context_info=>get_user_alias(  ).
*        DATA(time) = cl_abap_context_info=>get_system_time(  ).
*        MODIFY ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
*                     ENTITY Event
*                     UPDATE FIELDS ( CreatedAt CreatedBy LastChangedAt LastChangedBy LocalLastChangedAt )
*                     WITH VALUE #( FOR key IN details
*                                 (
*                                  %tky = key-%tky
*                                  CreatedAt = time
*                                  CreatedBy = user
*                                  LastChangedAt = time
*                                  LastChangedBy = user
*                                  LocalLastChangedAt = time
*                                 )
*                               ).
*       ENDLOOP.
*   ENDMETHOD.

ENDCLASS.

CLASS lhc_booking DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Booking RESULT result.

    METHODS CancelBooking FOR MODIFY
      IMPORTING keys FOR ACTION Booking~CancelBooking RESULT result.

    METHODS ConfirmBooking FOR MODIFY
      IMPORTING keys FOR ACTION Booking~ConfirmBooking RESULT result.

    METHODS GenerateInvoice FOR MODIFY
      IMPORTING keys FOR ACTION Booking~GenerateInvoice RESULT result.

    METHODS IssueTicket FOR MODIFY
      IMPORTING keys FOR ACTION Booking~IssueTicket RESULT result.

*    METHODS calculateBookingTotals FOR DETERMINE ON MODIFY
*      IMPORTING keys FOR Booking~calculateBookingTotals.

    METHODS SetInitialBookingValues FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Booking~SetInitialBookingValues.

    METHODS ValidateBookingCanIssues FOR VALIDATE ON SAVE
      IMPORTING keys FOR Booking~ValidateBookingCanIssues.

ENDCLASS.

CLASS lhc_booking IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD CancelBooking.
      READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
      ENTITY Booking
      FIELDS ( BookingId Status )
      WITH CORRESPONDING #( keys )
      RESULT DATA(bookings).

    LOOP AT bookings ASSIGNING FIELD-SYMBOL(<booking>).

      IF <booking>-Status = 'CHECKED_IN'.
        APPEND VALUE #( %tky = <booking>-%tky ) TO failed-booking.

        APPEND VALUE #(
          %tky = <booking>-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Checked-in bookings cannot be cancelled.'
          )
        ) TO reported-booking.

        CONTINUE.
      ENDIF.

      MODIFY ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
        ENTITY Booking
        UPDATE FIELDS ( Status )
        WITH VALUE #(
          (
            %tky   = <booking>-%tky
            Status = 'CANCELLED'
          )
        ).

    ENDLOOP.

    READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
      ENTITY Booking
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(updated_bookings).

    result = VALUE #( FOR booking IN updated_bookings
      (
        %tky   = booking-%tky
        %param = booking
      )
    ).

  ENDMETHOD.

  METHOD ConfirmBooking.

    READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
              ENTITY Booking
              FIELDS ( BookingId EventId PaymentStatus Status )
              WITH CORRESPONDING #( keys )
              RESULT DATA(bookings).

    LOOP AT bookings ASSIGNING FIELD-SYMBOL(<booking>).

      IF <booking>-Status <> 'DRAFT'.
        APPEND VALUE #( %tky = <booking>-%tky ) TO failed-booking.
        APPEND VALUE #(
                %tky = <booking>-%tky
                %msg = new_message_with_text(
                              severity = if_abap_behv_message=>severity-error
                              text     = 'Only DRAFT bookings can be confirmed'
                )
        ) TO reported-booking.

        CONTINUE.
      ENDIF.

      "Check that the event is approved
      SELECT COUNT( * )
            FROM zth_event
           WHERE event_id = @<booking>-EventId
           INTO @DATA(event_status).

      IF event_status <> 'APPROVED'.
        APPEND VALUE #( %tky = <booking>-%tky ) TO failed-booking.

        APPEND VALUE #(
          %tky = <booking>-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Booking can only be confirmed for an APPROVED event.'
          )
        ) TO reported-booking.

        CONTINUE.
      ENDIF.

       MODIFY ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
        ENTITY Booking
        UPDATE FIELDS ( Status )
        WITH VALUE #(
          (
            %tky   = <booking>-%tky
            Status = 'CONFIRMED'
          )
        ).
            "Optional: reduce available ticket quantity after confirmation
      SELECT booking_item_id,
             ticket_type_id,
             quantity
        FROM zth_booking_item
        WHERE booking_id = @<booking>-BookingId
        INTO TABLE @DATA(items).

      LOOP AT items ASSIGNING FIELD-SYMBOL(<item>).

        SELECT SINGLE available_quantity
          FROM zth_ticket_type
          WHERE ticket_type_id = @<item>-ticket_type_id
          INTO @DATA(available_qty).

        IF sy-subrc = 0 AND available_qty >= <item>-quantity.

          DATA(new_available_qty) = available_qty - <item>-quantity.

          UPDATE zth_ticket_type
            SET available_quantity = @new_available_qty
            WHERE ticket_type_id = @<item>-ticket_type_id.

        ELSE.

          APPEND VALUE #( %tky = <booking>-%tky ) TO failed-booking.

          APPEND VALUE #(
            %tky = <booking>-%tky
            %msg = new_message_with_text(
              severity = if_abap_behv_message=>severity-error
              text     = 'Not enough available ticket quantity.'
            )
          ) TO reported-booking.

        ENDIF.

      ENDLOOP.

    ENDLOOP.

    READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
      ENTITY Booking
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(updated_bookings).

    result = VALUE #( FOR booking IN updated_bookings
      (
        %tky   = booking-%tky
        %param = booking
      )
    ).



  ENDMETHOD.

  METHOD GenerateInvoice.
        READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
      ENTITY Booking
      FIELDS ( BookingId Status )
      WITH CORRESPONDING #( keys )
      RESULT DATA(bookings).

    LOOP AT bookings ASSIGNING FIELD-SYMBOL(<booking>).

      IF <booking>-Status <> 'CONFIRMED'.
        APPEND VALUE #( %tky = <booking>-%tky ) TO failed-booking.

        APPEND VALUE #(
          %tky = <booking>-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Invoice can only be generated for CONFIRMED bookings.'
          )
        ) TO reported-booking.

        CONTINUE.
      ENDIF.

      MODIFY ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
        ENTITY Booking
        UPDATE FIELDS ( Status )
        WITH VALUE #(
          (
            %tky   = <booking>-%tky
            Status = 'INVOICED'
          )
        ).

    ENDLOOP.

    READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
      ENTITY Booking
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(updated_bookings).

    result = VALUE #( FOR booking IN updated_bookings
      (
        %tky   = booking-%tky
        %param = booking
      )
    ).

  ENDMETHOD.

  METHOD IssueTicket.
         READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
      ENTITY Booking
      FIELDS ( BookingId Status PaymentStatus )
      WITH CORRESPONDING #( keys )
      RESULT DATA(bookings).

    LOOP AT bookings ASSIGNING FIELD-SYMBOL(<booking>).

      IF <booking>-PaymentStatus <> 'PAID'.
        APPEND VALUE #( %tky = <booking>-%tky ) TO failed-booking.

        APPEND VALUE #(
          %tky = <booking>-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Ticket can only be issued when payment status is PAID.'
          )
        ) TO reported-booking.

        CONTINUE.
      ENDIF.

      MODIFY ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
        ENTITY Booking
        UPDATE FIELDS ( Status )
        WITH VALUE #(
          (
            %tky   = <booking>-%tky
            Status = 'TICKET_ISSUED'
          )
        ).

    ENDLOOP.

    READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
      ENTITY Booking
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(updated_bookings).

    result = VALUE #( FOR booking IN updated_bookings
      (
        %tky   = booking-%tky
        %param = booking
      )
    ).
  ENDMETHOD.

*  METHOD calculateBookingTotals.
*
*     READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
*      ENTITY Booking
*      FIELDS ( BookingId )
*      WITH CORRESPONDING #( keys )
*      RESULT DATA(bookings).
*
*    LOOP AT bookings ASSIGNING FIELD-SYMBOL(<booking>).
*
*      SELECT SUM( gross_amount )    AS gross_amount,
*             SUM( discount_amount ) AS discount_amount,
*             SUM( net_amount )      AS item_net_amount
*        FROM zth_booking_item
*        WHERE booking_id = @<booking>-BookingId
*        INTO @DATA(total).
*
*
*       ENDIF.
*    ENDLOOP.
*
*      DATA(gross_amount)    = CONV decfloat34( total-gross_amount ).
*      DATA(discount_amount) = CONV decfloat34( total-discount_amount ).
*      DATA(item_net_amount) = CONV decfloat34( total-item_net_amount ).
*
*      DATA(tax_amount) = item_net_amount * '0.15'.
*      DATA(net_amount) = item_net_amount + tax_amount.
*
*      MODIFY ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
*        ENTITY Booking
*        UPDATE FIELDS ( GrossAmount DiscountAmount TaxAmount NetAmount )
*        WITH VALUE #(
*          (
*            %tky           = <booking>-%tky
*            GrossAmount    = gross_amount
*            DiscountAmount = discount_amount
*            TaxAmount      = tax_amount
*            NetAmount      = net_amount
*          )
*        ).
*
*  ENDMETHOD.

  METHOD SetInitialBookingValues.
        READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
      ENTITY Booking
      FIELDS ( BookingId Status PaymentStatus )
      WITH CORRESPONDING #( keys )
      RESULT DATA(bookings).

    LOOP AT bookings ASSIGNING FIELD-SYMBOL(<booking>).

      MODIFY ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
        ENTITY Booking
        UPDATE FIELDS ( Status PaymentStatus )
        WITH VALUE #(
          (
            %tky          = <booking>-%tky
            Status        = COND #( WHEN <booking>-Status IS INITIAL THEN 'DRAFT'
                                    ELSE <booking>-Status )
            PaymentStatus = COND #( WHEN <booking>-PaymentStatus IS INITIAL THEN 'PENDING'
                                    ELSE <booking>-PaymentStatus )
          )
        ).

    ENDLOOP.
  ENDMETHOD.

  METHOD ValidateBookingCanIssues.
         READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
      ENTITY Booking
      FIELDS ( BookingId Status PaymentStatus )
      WITH CORRESPONDING #( keys )
      RESULT DATA(bookings).

    LOOP AT bookings ASSIGNING FIELD-SYMBOL(<booking>).

      IF <booking>-Status = 'TICKET_ISSUED'
      AND <booking>-PaymentStatus <> 'PAID'.

        APPEND VALUE #( %tky = <booking>-%tky ) TO failed-booking.

        APPEND VALUE #(
          %tky = <booking>-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Ticket cannot be issued unless payment status is PAID.'
          )
        ) TO reported-booking.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.
...

ENDCLASS.

CLASS lhc_bookingitem DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS CalculateItemAmount FOR DETERMINE ON MODIFY
      IMPORTING keys FOR BookingItem~CalculateItemAmount.

    METHODS ValidateItemQuantity FOR VALIDATE ON SAVE
      IMPORTING keys FOR BookingItem~ValidateItemQuantity.

ENDCLASS.

CLASS lhc_bookingitem IMPLEMENTATION.

  METHOD CalculateItemAmount.
        READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
      ENTITY BookingItem
      FIELDS ( BookingItemId Quantity UnitPrice DiscountAmount )
      WITH CORRESPONDING #( keys )
      RESULT DATA(items).

    LOOP AT items ASSIGNING FIELD-SYMBOL(<item>).

      DATA(gross_amount) = <item>-Quantity * <item>-UnitPrice.

      DATA(discount_amount) = COND #(
        WHEN <item>-DiscountAmount IS INITIAL THEN 0
        ELSE <item>-DiscountAmount
      ).

      DATA(net_amount) = gross_amount - discount_amount.

      MODIFY ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
        ENTITY BookingItem
        UPDATE FIELDS ( GrossAmount DiscountAmount NetAmount )
        WITH VALUE #(
          (
            %tky           = <item>-%tky
            GrossAmount    = gross_amount
            DiscountAmount = discount_amount
            NetAmount      = net_amount
          )
        ).

    ENDLOOP.

  ENDMETHOD.

  METHOD ValidateItemQuantity.
        READ ENTITIES OF ZI_TH_EVENT IN LOCAL MODE
      ENTITY BookingItem
      FIELDS ( BookingItemId TicketTypeId Quantity )
      WITH CORRESPONDING #( keys )
      RESULT DATA(items).

    LOOP AT items ASSIGNING FIELD-SYMBOL(<item>).

      IF <item>-Quantity <= 0.

        APPEND VALUE #( %tky = <item>-%tky ) TO failed-bookingitem.

        APPEND VALUE #(
          %tky = <item>-%tky
          %element-Quantity = if_abap_behv=>mk-on
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Ticket quantity must be greater than zero.'
          )
        ) TO reported-bookingitem.

        CONTINUE.

      ENDIF.

      SELECT SINGLE available_quantity
        FROM zth_ticket_type
        WHERE ticket_type_id = @<item>-TicketTypeId
        INTO @DATA(available_qty).

      IF sy-subrc = 0 AND <item>-Quantity > available_qty.

        APPEND VALUE #( %tky = <item>-%tky ) TO failed-bookingitem.

        APPEND VALUE #(
          %tky = <item>-%tky
          %element-Quantity = if_abap_behv=>mk-on
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Requested quantity exceeds available ticket quantity.'
          )
        ) TO reported-bookingitem.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.


