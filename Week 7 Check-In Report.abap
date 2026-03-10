CLASS zcl_8169_week_7 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.



CLASS zcl_8169_week_7 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA text TYPE string VALUE `  Let's talk about ABAP and SAP BTP  `.
    DATA result TYPE i.
    DATA txt TYPE string.

    out->write( |Original Text: { text }| ).

*------------------------------------
* Description Functions
*------------------------------------

    result = strlen( text ).
    out->write( |STRLEN = { result }| ).

    result = numofchar( text ).
    out->write( |NUMOFCHAR = { result }| ).

    result = count( val = text sub = 'A' case = abap_false ).
    out->write( |COUNT of 'A' = { result }| ).

    result = find( val = text sub = 'ABAP' ).
    out->write( |FIND 'ABAP' offset = { result }| ).


*------------------------------------
* Processing Functions
*------------------------------------

    out->write( |TO_UPPER = { to_upper( text ) }| ).
    out->write( |TO_LOWER = { to_lower( text ) }| ).
    out->write( |REVERSE  = { reverse( text ) }| ).

    out->write(
      |SUBSTRING = { substring( val = text off = 4 len = 10 ) }|
    ).

    out->write( |CONDENSE = { condense( val = text ) }| ).


*------------------------------------
* SEGMENT Example (CSV parsing)
*------------------------------------

    DATA csv TYPE string VALUE `SAP,ABAP,BTP,CLOUD`.

    out->write( |Segment 1 = { segment( val = csv sep = ',' index = 1 ) }| ).
    out->write( |Segment 2 = { segment( val = csv sep = ',' index = 2 ) }| ).
    out->write( |Segment 3 = { segment( val = csv sep = ',' index = 3 ) }| ).


*------------------------------------
* Predicate Function
*------------------------------------

    IF contains( val = text sub = 'ABAP' ).
      out->write( 'Text contains ABAP' ).
    ENDIF.


*------------------------------------
* Regex Example
*------------------------------------

    DATA flight TYPE string VALUE `AA123`.

    IF matches( val = flight pcre = '[A-Z]{2}[0-9]{3}' ).
      out->write( |Flight code { flight } is valid| ).
    ENDIF.


*------------------------------------
* Replace Placeholder Example
*------------------------------------

    DATA carrier_id TYPE string VALUE 'LH'.
    DATA conn_id TYPE string VALUE '0400'.
    DATA airport_from TYPE string VALUE 'FRA'.
    DATA airport_to TYPE string VALUE 'JFK'.

    txt = 'Flight &carrid& &connid& from &from& to &to&'.

    txt = replace( val = txt sub = '&carrid&' with = carrier_id ).
    txt = replace( val = txt sub = '&connid&' with = conn_id ).
    txt = replace( val = txt sub = '&from&' with = airport_from ).
    txt = replace( val = txt sub = '&to&' with = airport_to ).

    out->write( txt ).

  ENDMETHOD.

ENDCLASS.
