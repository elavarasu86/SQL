/*Raise Application Error:
When an exception is raised using "Raise Application Erro", User has ability to raise a exception with error number and description.

When an user defined exception is not handled than oracle will through "unhandled user-definedexception". But with Raise Application Error user has ability to give number and description*/

-- In the below code exception is not handled.
DECLARE
    v1       NUMBER := 10;
    v2       NUMBER := 0;
    v_result NUMBER;
    e_denom_is_zero EXCEPTION;
BEGIN
    IF v2 = 0 THEN
      RAISE e_denom_is_zero;
    ELSE
      v_result := v1 / v2;
    END IF;
END;

/ 

--Below code is written with Raise Application Error exception.

DECLARE
    v1       NUMBER := 10;
    v2       NUMBER := 0;
    v_result NUMBER;
    e_denom_is_zero EXCEPTION;
BEGIN
    IF v2 = 0 THEN
      raise_application_error(-20001,' e_denom_is_zero');
    ELSE
      v_result := v1 / v2;
    END IF;
END;

/ 
*******************
SQLERRM - Return Description about the exception
SQLCODE - Return Error Code
Example:
DECLARE
    v1       NUMBER := 10;
    v2       NUMBER := 0;
    v_result NUMBER;
    e_denom_is_zero EXCEPTION;
BEGIN
    IF v2 = 0 THEN
      raise_application_error(-20001,' e_denom_is_zero');
    ELSE
      v_result := v1 / v2;
    END IF;
EXCEPTION WHEN OTHERS THEN
    dbms_output.put_line('SQLERRM - '|| SQLERRM);
    dbms_output.put_line('SQLCODE - '|| SQLCODE);
END;

/ 
