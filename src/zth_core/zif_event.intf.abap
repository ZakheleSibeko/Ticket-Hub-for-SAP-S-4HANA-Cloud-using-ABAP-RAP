INTERFACE zif_event PUBLIC.

  METHODS validate_event
    raising zcx_event.

  METHODS calculate_available_capacity
     RETURNING VALUE(rv_capacity) TYPE int4.

  METHODS calculate_duration
     RETURNING VALUE(rv_days) TYPE i.

  METHODS calculate_estimated_revenue
     RETURNING VALUE(rv_revenue) TYPE decfloat34.

ENDINTERFACE.
