/*What is Error/Exception in PLSQL?
	An abnormal situation while executing statements.
	Two Types:
		1. Compile time exception
		2. Run time exception
		
SELECT * FROM USER_ERRORS;
*/

Scenario1:
CREATE OR replace FUNCTION Fn_div(inpt1 NUMBER,
                                  intp2 NUMBER)
RETURN NUMBER
IS
  lv_temp NUMBER;
BEGIN
    RETURN inpt1 / inpt2;
END;

/ 

set serveroutput ON
BEGIN
    dbms_output.Put_line(Fn_div(1, 2));
END;

/ 

set serveroutput ON
DECLARE
    v_emp_details employees%ROWTYPE;
BEGIN
    SELECT *
    INTO   v_emp_details
    FROM   employees
    WHERE  empno = 9999;
EXCEPTION
    WHEN OTHERS THEN
      dbms_output.Put_line('No employee details found');
END;

/ 