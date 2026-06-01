CLASS lhc_Booking DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Booking RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Booking RESULT result.

    METHODS CancelBooking FOR MODIFY
      IMPORTING keys FOR ACTION Booking~CancelBooking RESULT result.

    METHODS CompletePayment FOR MODIFY
      IMPORTING keys FOR ACTION Booking~CompletePayment RESULT result.

    METHODS ConfirmBooking FOR MODIFY
      IMPORTING keys FOR ACTION Booking~ConfirmBooking RESULT result.

    METHODS SetInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Booking~SetInitialStatus.

    METHODS ValidateBooking FOR VALIDATE ON SAVE
      IMPORTING keys FOR Booking~ValidateBooking.

ENDCLASS.

CLASS lhc_Booking IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD CancelBooking.
    MODIFY ENTITIES OF ZI_TH_BOOKING_SD IN LOCAL MODE
                 ENTITY Booking
                 UPDATE FIELDS ( Status )
                 WITH VALUE #( FOR key IN keys
                         (
                          %tky   = key-%tky
                          Status = 'CANCELLED'
                         )
                 ).
     READ ENTITIES OF ZI_TH_BOOKING_SD IN LOCAL MODE
               ENTITY Booking
               FIELDS ( Status )
               WITH CORRESPONDING #( keys )
               RESULT DATA(lt_bookings).

     result = VALUE #( FOR ls_booking IN lt_bookings
                     (
                      %tky   = ls_booking-%tky
                      %param = ls_booking
                     )
                 ).
  ENDMETHOD.

  METHOD CompletePayment.
      MODIFY ENTITIES OF ZI_TH_BOOKING_SD IN LOCAL MODE
                 ENTITY Booking
                 UPDATE FIELDS ( Status )
                 WITH VALUE #( FOR key IN keys
                         (
                          %tky   = key-%tky
                          Status = 'COMPLETED'
                         )
                 ).
     READ ENTITIES OF ZI_TH_BOOKING_SD IN LOCAL MODE
               ENTITY Booking
               FIELDS ( Status )
               WITH CORRESPONDING #( keys )
               RESULT DATA(lt_bookings).

     result = VALUE #( FOR ls_booking IN lt_bookings
                     (
                      %tky   = ls_booking-%tky
                      %param = ls_booking
                     )
                 ).
  ENDMETHOD.

  METHOD ConfirmBooking.
       MODIFY ENTITIES OF ZI_TH_BOOKING_SD IN LOCAL MODE
                 ENTITY Booking
                 UPDATE FIELDS ( Status )
                 WITH VALUE #( FOR key IN keys
                         (
                          %tky   = key-%tky
                          Status = 'CONFIRMED'
                         )
                 ).
     READ ENTITIES OF ZI_TH_BOOKING_SD IN LOCAL MODE
               ENTITY Booking
               FIELDS ( Status )
               WITH CORRESPONDING #( keys )
               RESULT DATA(lt_bookings).

     result = VALUE #( FOR ls_booking IN lt_bookings
                     (
                      %tky   = ls_booking-%tky
                      %param = ls_booking
                     )
                 ).
  ENDMETHOD.

  METHOD SetInitialStatus.
    MODIFY ENTITIES OF ZI_TH_BOOKING_SD IN LOCAL MODE
                ENTITY Booking
                UPDATE FIELDS ( Status )
                WITH VALUE #( FOR key IN keys
                             (
                              %tky = key-%tky
                              Status = 'DRAFT'
                             )
                           ).
  ENDMETHOD.

  METHOD ValidateBooking.
      READ ENTITIES OF ZI_TH_BOOKING_SD IN LOCAL MODE
                ENTITY Booking
                FIELDS ( BookingId )
                WITH CORRESPONDING #( keys )
                RESULT DATA(lt_bookings).

     LOOP AT lt_bookings INTO DATA(lt_booking).
       IF lt_booking-BookingId IS INITIAL.
          APPEND VALUE #(
                    %tky = lt_booking-%tky
                    %msg = new_message_with_text(
                                    severity  = if_abap_behv_message=>severity-error
                                    text      = 'Bookings with BOOKINGIDS can be validated'
                                    )
          ) TO reported-booking.
       ENDIF.
     ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_BookingItem DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS CalculateNetAmount FOR DETERMINE ON MODIFY
      IMPORTING keys FOR BookingItem~CalculateNetAmount.

ENDCLASS.

CLASS lhc_BookingItem IMPLEMENTATION.

  METHOD CalculateNetAmount.

      READ ENTITIES OF ZI_TH_BOOKING_SD IN LOCAL MODE
                ENTITY Booking BY \_BookingItem
                ALL FIELDS
                WITH CORRESPONDING #( keys )
                RESULT DATA(lt_bookings).

      LOOP AT lt_bookings INTO DATA(lt_booking).
           MODIFY ENTITIES OF ZI_TH_BOOKING_SD IN LOCAL MODE
                       ENTITY BookingItem
                       UPDATE FIELDS ( NetAmount )
                       WITH VALUE #(
                                    (
                                       %tky = lt_booking-%tky
                                       NetAmount = lt_booking-Quantity * lt_booking-UnitPrice
                                    )
                                   ).
      ENDLOOP.

  ENDMETHOD.

ENDCLASS.
