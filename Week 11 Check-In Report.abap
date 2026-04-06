REPORT z_employee_demo.

DATA: ls_employee TYPE zemployee_demo,
      lt_employee TYPE TABLE OF zemployee_demo.

ls_employee-client = sy-mandt.
ls_employee-employee_id = '0000000001'.
ls_employee-first_name = 'Cade'.
ls_employee-last_name = 'Kardes'.
ls_employee-department = 'IT'.
ls_employee-salary = '50000'.
ls_employee-currency_code = 'USD'.

INSERT zemployee_demo FROM ls_employee.

IF sy-subrc = 0.
  WRITE: / 'Employee inserted successfully'.
ELSE.
  WRITE: / 'Insert failed'.
ENDIF.

SELECT * FROM zemployee_demo INTO TABLE lt_employee.

LOOP AT lt_employee INTO ls_employee.
  WRITE: / ls_employee-employee_id,
           ls_employee-first_name,
           ls_employee-last_name,
           ls_employee-salary,
           ls_employee-currency_code.
ENDLOOP.
