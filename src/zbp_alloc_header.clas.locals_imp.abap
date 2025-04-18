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

    METHODS setTimestamps FOR DETERMINE ON MODIFY
      IMPORTING keys FOR header~setTimestamps.

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

  METHOD setTimestamps.
    DATA: update TYPE TABLE FOR UPDATE ZALLOC_HEADER.

    " Read current data
    READ ENTITIES OF ZALLOC_HEADER IN LOCAL MODE
      ENTITY header
        ALL FIELDS
        WITH CORRESPONDING #( keys )
      RESULT DATA(headers).

    LOOP AT headers ASSIGNING FIELD-SYMBOL(<header>).
      APPEND VALUE #( %key = <header>-%key
                     LastChangedAt = cl_abap_context_info=>get_system_date( )
                     LocalLastChangedAt = cl_abap_context_info=>get_system_date( )
                   ) TO update.
    ENDLOOP.

    " Update the timestamps
    MODIFY ENTITIES OF ZALLOC_HEADER IN LOCAL MODE
      ENTITY header
        UPDATE FIELDS ( LastChangedAt LocalLastChangedAt )
        WITH update.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_detail DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS calculateAmount FOR DETERMINE ON MODIFY
      IMPORTING keys FOR detail~calculateAmount.
ENDCLASS.

CLASS lhc_detail IMPLEMENTATION.
  METHOD calculateAmount.
    " Implement calculation logic here
  ENDMETHOD.
ENDCLASS.

CLASS lhc_item DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS calculateAmount FOR DETERMINE ON MODIFY
      IMPORTING keys FOR item~calculateAmount.
ENDCLASS.

CLASS lhc_item IMPLEMENTATION.
  METHOD calculateAmount.
    " Implement calculation logic here
  ENDMETHOD.
ENDCLASS. 