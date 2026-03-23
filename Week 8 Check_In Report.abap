REPORT z_demo_program.

INTERFACE lif_vehicle.
  METHODS: display_info.
ENDINTERFACE.

CLASS lcl_vehicle DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_vehicle.
    METHODS: constructor IMPORTING iv_name TYPE string,
             display_info REDEFINITION.
  PROTECTED SECTION.
    DATA: gv_name TYPE string.
ENDCLASS.

CLASS lcl_vehicle IMPLEMENTATION.
  METHOD constructor.
    gv_name = iv_name.
  ENDMETHOD.

  METHOD display_info.
    WRITE: / 'Vehicle:', gv_name.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_car DEFINITION INHERITING FROM lcl_vehicle.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING iv_name TYPE string
                                    iv_doors TYPE i,
             display_info REDEFINITION.
  PRIVATE SECTION.
    DATA: gv_doors TYPE i.
ENDCLASS.

CLASS lcl_car IMPLEMENTATION.
  METHOD constructor.
    super->constructor( iv_name ).
    gv_doors = iv_doors.
  ENDMETHOD.

  METHOD display_info.
    WRITE: / 'Car:', gv_name, 'Doors:', gv_doors.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_factory DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS create_car
      RETURNING VALUE(ro_car) TYPE REF TO lcl_vehicle.
ENDCLASS.

CLASS lcl_factory IMPLEMENTATION.
  METHOD create_car.
    ro_car = NEW lcl_car( iv_name = 'Toyota' iv_doors = 4 ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: lt_vehicles TYPE STANDARD TABLE OF REF TO lcl_vehicle,
        lo_vehicle  TYPE REF TO lcl_vehicle.

  " Factory method usage
  lo_vehicle = lcl_factory=>create_car( ).
  APPEND lo_vehicle TO lt_vehicles.

  " Field symbol loop (faster than work area)
  FIELD-SYMBOLS: <fs_vehicle> TYPE REF TO lcl_vehicle.

  LOOP AT lt_vehicles ASSIGNING <fs_vehicle>.
    <fs_vehicle>->display_info( ).
  ENDLOOP.

  AUTHORITY-CHECK OBJECT 'S_TCODE'
    ID 'TCD' FIELD 'SE38'.

  IF sy-subrc <> 0.
    WRITE: / 'User not authorized to run SE38'.
  ELSE.
    WRITE: / 'Authorization check passed'.
  ENDIF.