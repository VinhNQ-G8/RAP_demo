CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS validateInvoiceNo FOR VALIDATE ON SAVE
      IMPORTING keys FOR Header~validateInvoiceNo.

    METHODS calculateTotalAmount FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Header~calculateTotalAmount.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Header RESULT result.

ENDCLASS.

CLASS lhc_Header IMPLEMENTATION.

  METHOD validateInvoiceNo.
    READ ENTITIES OF zc_alloc_header IN LOCAL MODE
      ENTITY Header
        FIELDS ( InvoiceNo )
        WITH CORRESPONDING #( keys )
      RESULT DATA(headers).

    LOOP AT headers INTO DATA(header).
      " Check if invoice number exists and is valid
      SELECT SINGLE @abap_true
        FROM zalloc_header
        WHERE invoice_no = @header-InvoiceNo
          AND allocation_id <> @header-AllocationId
        INTO @DATA(exists).

      IF exists = abap_true.
        APPEND VALUE #( %tky = header-%tky ) TO failed-header.
        APPEND VALUE #( %tky = header-%tky
                       %msg = new_message_with_text(
                         severity = if_abap_behv_message=>severity-error
                         text     = 'Invoice number already exists' )
                       %element-InvoiceNo = if_abap_behv=>mk-on ) TO reported-header.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD calculateTotalAmount.
    READ ENTITIES OF zc_alloc_header IN LOCAL MODE
      ENTITY Header
        FIELDS ( AllocationId Currency )
        WITH CORRESPONDING #( keys )
      RESULT DATA(headers).

    LOOP AT headers INTO DATA(header).
      " Calculate total amount from details
      SELECT SUM( amount )
        FROM zalloc_detail
        WHERE allocation_id = @header-AllocationId
        INTO @DATA(total_amount).

      MODIFY ENTITIES OF zc_alloc_header IN LOCAL MODE
        ENTITY Header
          UPDATE FIELDS ( TotalAmount )
          WITH VALUE #( ( %tky = header-%tky
                         TotalAmount = total_amount ) ).
    ENDLOOP.
  ENDMETHOD.

  METHOD get_instance_features.
    " Read relevant header instance data
    READ ENTITIES OF zc_alloc_header IN LOCAL MODE
      ENTITY Header
        FIELDS ( TotalAmount )
        WITH CORRESPONDING #( keys )
      RESULT DATA(headers).

    result = VALUE #( FOR header IN headers
                     ( %tky = header-%tky
                       %field-TotalAmount = if_abap_behv=>fc-f-read_only ) ).
  ENDMETHOD.

ENDCLASS.

CLASS lhc_Detail DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS validateAmount FOR VALIDATE ON SAVE
      IMPORTING keys FOR Detail~validateAmount.

    METHODS calculateTax FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Detail~calculateTax.

ENDCLASS.

CLASS lhc_Detail IMPLEMENTATION.

  METHOD validateAmount.
    READ ENTITIES OF zc_alloc_header IN LOCAL MODE
      ENTITY Detail
        FIELDS ( Amount Currency )
        WITH CORRESPONDING #( keys )
      RESULT DATA(details).

    LOOP AT details INTO DATA(detail).
      IF detail-Amount <= 0.
        APPEND VALUE #( %tky = detail-%tky ) TO failed-detail.
        APPEND VALUE #( %tky = detail-%tky
                       %msg = new_message_with_text(
                         severity = if_abap_behv_message=>severity-error
                         text     = 'Amount must be greater than zero' )
                       %element-Amount = if_abap_behv=>mk-on ) TO reported-detail.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD calculateTax.
    READ ENTITIES OF zc_alloc_header IN LOCAL MODE
      ENTITY Detail
        FIELDS ( Amount TaxRate )
        WITH CORRESPONDING #( keys )
      RESULT DATA(details).

    LOOP AT details INTO DATA(detail).
      " Calculate tax based on amount and tax rate
      DATA(tax_amount) = detail-Amount * detail-TaxRate / 100.

      MODIFY ENTITIES OF zc_alloc_header IN LOCAL MODE
        ENTITY Detail
          UPDATE FIELDS ( Amount )
          WITH VALUE #( ( %tky = detail-%tky
                         Amount = detail-Amount + tax_amount ) ).
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_Item DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS validateQuantity FOR VALIDATE ON SAVE
      IMPORTING keys FOR Item~validateQuantity.

    METHODS calculateAmount FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Item~calculateAmount.

ENDCLASS.

CLASS lhc_Item IMPLEMENTATION.

  METHOD validateQuantity.
    READ ENTITIES OF zc_alloc_header IN LOCAL MODE
      ENTITY Item
        FIELDS ( Quantity Unit )
        WITH CORRESPONDING #( keys )
      RESULT DATA(items).

    LOOP AT items INTO DATA(item).
      IF item-Quantity <= 0.
        APPEND VALUE #( %tky = item-%tky ) TO failed-item.
        APPEND VALUE #( %tky = item-%tky
                       %msg = new_message_with_text(
                         severity = if_abap_behv_message=>severity-error
                         text     = 'Quantity must be greater than zero' )
                       %element-Quantity = if_abap_behv=>mk-on ) TO reported-item.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD calculateAmount.
    READ ENTITIES OF zc_alloc_header IN LOCAL MODE
      ENTITY Item
        FIELDS ( Quantity Unit Material )
        WITH CORRESPONDING #( keys )
      RESULT DATA(items).

    LOOP AT items INTO DATA(item).
      " Calculate amount based on quantity and material price
      " Here you would typically get the price from a pricing table
      DATA(unit_price) = 100. " Example fixed price
      DATA(amount) = item-Quantity * unit_price.

      MODIFY ENTITIES OF zc_alloc_header IN LOCAL MODE
        ENTITY Item
          UPDATE FIELDS ( Amount )
          WITH VALUE #( ( %tky = item-%tky
                         Amount = amount ) ).
    ENDLOOP.
  ENDMETHOD.

ENDCLASS. 