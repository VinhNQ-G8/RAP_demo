CLASS lhc_header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR header RESULT result.

    METHODS validateInvoice FOR VALIDATE ON SAVE
      IMPORTING keys FOR header~validateInvoice.

    METHODS allocateByAmount FOR MODIFY
      IMPORTING keys FOR ACTION header~allocateByAmount RESULT result.

    METHODS allocateByQuantity FOR MODIFY
      IMPORTING keys FOR ACTION header~allocateByQuantity RESULT result.

ENDCLASS.

CLASS lhc_header IMPLEMENTATION.
  METHOD get_instance_features.
  ENDMETHOD.

  METHOD validateInvoice.
  ENDMETHOD.

  METHOD allocateByAmount.
  ENDMETHOD.

  METHOD allocateByQuantity.
  ENDMETHOD.

ENDCLASS. 