@EndUserText.label: 'Employee View with Calculations'
define view entity Z_C_EMPLOYEE_DEMO
  as select from zemployee
{
  key EmployeeId,
      FirstName,
      LastName,
      DepartmentId,
      AnnualSalary,
      CurrencyCode,

  @EndUserText.label: 'Employee Role'
  case 
    when EmployeeId = HeadId      then 'H'
    when EmployeeId = AssistantId then 'A'
    else ' '
  end as EmployeeRole,

  @EndUserText.label: 'Monthly Salary'
  @Semantics.amount.currencyCode: 'CurrencyCode'
  cast( AnnualSalary as abap.fltp ) / 12.0 as MonthlySalary
}

REPORT z_employee_demo.

DATA: lt_employees TYPE TABLE OF z_c_employee_demo,
      ls_employee  TYPE z_c_employee_demo.

SELECT *
  FROM z_c_employee_demo
  INTO TABLE lt_employees.

LOOP AT lt_employees INTO ls_employee.
  WRITE: / 'ID:', ls_employee-EmployeeId,
           'Name:', ls_employee-FirstName, ls_employee-LastName,
           'Role:', ls_employee-EmployeeRole,
           'Monthly Salary:', ls_employee-MonthlySalary.
ENDLOOP.