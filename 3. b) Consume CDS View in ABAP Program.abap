*&---------------------------------------------------------------------*
*& Report zcds_customer
*&---------------------------------------------------------------------*
*& Author   :   Nikhil Mishra
*& Date     :   18.09.2020
*& Desc     : Demo program to consume CDS View with parameter in
*&            ABAP Program
*& Warning: Select Options are not supported in CDSV with parameters
*&---------------------------------------------------------------------*
REPORT zcds_customer.

*&---------------------------------------------------------------------*
*& Data Declaration
*&---------------------------------------------------------------------*
DATA: knvv TYPE knvv.

*&---------------------------------------------------------------------*
*& Selection Screen
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.
PARAMETERS: p_vkorg TYPE knvv-vkorg,
            p_vtweg TYPE knvv-vtweg.
SELECTION-SCREEN END OF BLOCK b1.

*&---------------------------------------------------------------------*
*& Initialization
*&---------------------------------------------------------------------*
INITIALIZATION.
  p_vkorg = '1710'.
  p_vtweg = '10'.

*&---------------------------------------------------------------------*
*& Get Data
*&---------------------------------------------------------------------*
START-OF-SELECTION.
  SELECT * FROM zcdsv_customer( p_vkorg = @p_vkorg, p_vtweg = @p_vtweg )
                  INTO TABLE @DATA(lt_customers).

*&---------------------------------------------------------------------*
*& Get Data
*&---------------------------------------------------------------------*
END-OF-SELECTION.

  IF lt_customers IS NOT INITIAL.
    TRY.
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table   = DATA(lo_salv)
          CHANGING
            t_table        = lt_customers
        ).
      CATCH cx_salv_msg.    " always catch exceptions
    ENDTRY.

    lo_salv->get_functions( )->set_all( abap_true ).
    lo_salv->get_display_settings(  )->set_striped_pattern( abap_true ).
    lo_salv->display( ).

  ELSE.
    MESSAGE 'No data for selection creteria.' TYPE 'I'.
    LEAVE LIST-PROCESSING.
  ENDIF.