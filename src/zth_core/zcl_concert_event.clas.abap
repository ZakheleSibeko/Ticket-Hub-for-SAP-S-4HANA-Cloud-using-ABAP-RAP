CLASS zcl_concert_event DEFINITION
  PUBLIC
  INHERITING FROM zcl_abs_event
  CREATE PUBLIC .

  PUBLIC SECTION.

  METHODS zif_event~calculate_available_capacity REDEFINITION.
  METHODS zif_event~calculate_estimated_revenue REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_concert_event IMPLEMENTATION.

  METHOD zif_event~calculate_available_capacity.
       rv_capacity = mv_total_capacity - mv_available_capacity.
  ENDMETHOD.

  METHOD zif_event~calculate_estimated_revenue.
       rv_revenue = mv_total_capacity * '450'.
  ENDMETHOD.

ENDCLASS.
