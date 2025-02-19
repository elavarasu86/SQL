Parameterized Cursor.
Help us to pass a parameter to filter the result set on cursor.

Option1:

set serveroutput ON
DECLARE
    lv_deptno NUMBER;
    --from below statement we are adding a condition to filter on cursor.
    CURSOR emp_name_list IS
      SELECT ename
      FROM   emp
      WHERE  deptno = lv_deptno;
    v_name    VARCHAR2(100);
BEGIN
    dbms_output.Put_line('Emp from deptno 10');

    lv_deptno := 10;
    -- setting variable with value 10 this will be passed as parameter

    OPEN emp_name_list;

    LOOP
        FETCH emp_name_list INTO v_name;

        exit WHEN emp_name_list%NOTFOUND;

        dbms_output.Put_line(v_name);
    END LOOP;

    CLOSE emp_name_list;

    dbms_output.Put_line('Emp from deptno 20');

    lv_deptno := 20;
    -- setting variable with value 20 this will be passed as parameter

    OPEN emp_name_list;

    LOOP
        FETCH emp_name_list INTO v_name;

        exit WHEN emp_name_list%NOTFOUND;

        dbms_output.Put_line(v_name);
    END LOOP;

    CLOSE emp_name_list;
END;

/ 

option 2:

set serveroutput ON
DECLARE
    
    --from below statement we are adding a condition to filter on cursor.
    CURSOR emp_name_list(p_deptno number) IS
      SELECT ename
      FROM   emp
      WHERE  deptno = p_deptno;
    v_name    VARCHAR2(100);
BEGIN
    dbms_output.Put_line('Emp from deptno 10');

    -- setting variable with value 10 this will be passed as parameter

    OPEN emp_name_list(10);

    LOOP
        FETCH emp_name_list INTO v_name;

        exit WHEN emp_name_list%NOTFOUND;

        dbms_output.Put_line(v_name);
    END LOOP;

    CLOSE emp_name_list;

    dbms_output.Put_line('Emp from deptno 20');

    -- setting variable with value 20 this will be passed as parameter

    OPEN emp_name_list(20);

    LOOP
        FETCH emp_name_list INTO v_name;

        exit WHEN emp_name_list%NOTFOUND;

        dbms_output.Put_line(v_name);
    END LOOP;

    CLOSE emp_name_list;
END;

/ 

*******************
For cursor:
if a select statement going to be used only once then we can go ahead and use for cursor. for cursor will take care of open fetch and closing cursor.

Option1:
SET serveroutput ON
BEGIN
  FOR i IN
  (
         SELECT ename
         FROM   emp)
  LOOP
    dbms_output.Put_line(i.ename);
  END LOOP;
END;
/

Option2: (explicit cursor with name)
set serveroutput ON
DECLARE
    CURSOR emp_name_list(
      p_deptno NUMBER) IS
      SELECT ename
      FROM   emp
      WHERE  deptno = p_deptno;
BEGIN
    dbms_output.Put_line('emp of deptno 10');

    FOR i IN emp_name_list(10) LOOP
        dbms_output.Put_line(i.ename);
    END LOOP;
END;

/ 