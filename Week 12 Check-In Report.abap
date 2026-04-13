@EndUserText.label : 'Department'
@AbapCatalog.tableCategory : #TRANSPARENT
define table zdepment {

  key client      : abap.clnt not null;
  key id          : abap.numc(4);

  description     : abap.char(40);

  @AbapCatalog.foreignKey.screenCheck : false
  head_id         : abap.numc(6)
    with foreign key [0..1,0..1] zemploy
      where client      = zdepment.client
        and employee_id = zdepment.head_id;

  @AbapCatalog.foreignKey.screenCheck : false
  assistant_id    : abap.numc(6)
    with foreign key [0..1,1] zemploy
      where client      = zdepment.client
        and employee_id = zdepment.assistant_id;

}

@EndUserText.label : 'Employee'
@AbapCatalog.tableCategory : #TRANSPARENT
define table zemploy {

  key client        : abap.clnt not null;
  key employee_id   : abap.numc(6);

  name              : abap.char(40);

  @AbapCatalog.foreignKey.screenCheck : false
  department_id     : abap.numc(4)
    with foreign key [0..*,1] zdepment
      where client = zemploy.client
        and id     = zemploy.department_id;

}

CLASS zcl_demo_relationship DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS zcl_demo_relationship IMPLEMENTATION.

  METHOD main.

    "Insert Departments
    INSERT VALUE #( client = sy-mandt id = '0001' description = 'IT' ) INTO zdepment.
    INSERT VALUE #( client = sy-mandt id = '0002' description = 'HR' ) INTO zdepment.

    "Insert Employees
    INSERT VALUE #( client = sy-mandt employee_id = '000001' name = 'Alice' department_id = '0001' ) INTO zemploy.
    INSERT VALUE #( client = sy-mandt employee_id = '000002' name = 'Bob'   department_id = '0001' ) INTO zemploy.
    INSERT VALUE #( client = sy-mandt employee_id = '000003' name = 'Eve'   department_id = '0002' ) INTO zemploy.

    DATA lt_employees TYPE TABLE OF zemploy.
    SELECT * FROM zemploy INTO TABLE lt_employees.

    LOOP AT lt_employees INTO DATA(ls_emp).
      WRITE: / ls_emp-employee_id, ls_emp-name, ls_emp-department_id.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.