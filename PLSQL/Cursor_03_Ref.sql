Ref Cursor
We can use single cursor to open completely different sets of query
While opening Ref Cursor only we will use select statement.

Same cursor variable can be used for different select statement.

1. storngly Typed - have to mention return type
2. Weekly Typed -- should not be having return type.

why ref cursor:

DECLARE
  CURSOR emp_name_list IS
    SELECT ename
    FROM   emp;

CURSOR dept_name_list IS
  SELECT dname
  FROM   dept;

v_name VARCHAR2(100);
BEGIN
  dbms_output.Put_line('Employee Name');
  OPEN emp_name_list;
  LOOP
    FETCH emp_name_list
    INTO  v_name;
    
    EXIT
  WHEN emp_name_list%NOTFOUND;
    dbms_output.Put_line(v_name);
  END LOOP;
  dbms_output.Put_line('Department Name');
  OPEN dept_name_list;
  LOOP
    FETCH dept_name_list
    INTO  v_name;
    
    EXIT
  WHEN dept_name_list%NOTFOUND;
    dbms_output.Put_line(v_name);
  END LOOP.
END;
/

-- in the above plsql block we have created two cursor to get employee and department details. Instead of creating two cursor we can go with one Ref cursor.

DECLARE
    TYPE ref_cur_type IS ref CURSOR;
    rc_emp_list_cur REF_CUR_TYPE;
    v_name          VARCHAR2(30);
    v_id            NUMBER;
BEGIN
    OPEN rc_emp_list_cur FOR
      SELECT ename
      FROM   emp;

    LOOP
        FETCH rc_emp_list_cur INTO v_name;

        exit WHEN rc_emp_list_cur%NOTFOUND;

        dbms_output.Put_line(v_name);
    END LOOP;

    CLOSE rc_emp_list_cur;

    OPEN rc_emp_list_cur FOR
      SELECT dname
      FROM   dept;--'select dname from dept'; we can use dynamic query also.

    LOOP
        FETCH rc_emp_list_cur INTO v_name;

        exit WHEN rc_emp_list_cur%NOTFOUND;

        dbms_output.Put_line(v_name);
    END LOOP;

    CLOSE rc_emp_list_cur;
END;

/ 

-- by using above ref cursor we used one cursor to handle two different sql statement.

Strongly typed ref cursor:

DECLARE
    TYPE ref_cur_type IS ref CURSOR
    RETURN emp%ROWTYPE; -- this return type tells this is strongly type ref cursor. IF you remove it become weekly typed ref cursor. With this return type cursor can only return emp details.
    rc_emp_list_cur REF_CUR_TYPE;
    v_emp_row       emp%ROWTYPE;
    v_dept_row      dept%ROWTYPE;
BEGIN
    dbms_output.Put_line('cursor');

    OPEN rc_emp_list_cur FOR
      SELECT *
      FROM   emp;

    LOOP
        FETCH rc_emp_list_cur INTO v_emp_row;

        exit WHEN rc_emp_list_cur%nowfound;

        dbms_output.Put_line(v_emp_row.ename
                             ||'-'
                             ||v_emp_row.job);
    END LOOP;
END;
/

--Another way to create ref cursor: this way we can create only weekly typed ref cursor.
DECLARE
    v_emp_row       emp%ROWTYPE;
    v_dept_row      dept%ROWTYPE;
	rc_emp_list_cur sys_refcursor;-- Oracle defined ref Cursor
BEGIN
    dbms_output.Put_line('cursor');

    OPEN rc_emp_list_cur FOR
      SELECT *
      FROM   emp;

    LOOP
        FETCH rc_emp_list_cur INTO v_emp_row;

        exit WHEN rc_emp_list_cur%nowfound;

        dbms_output.Put_line(v_emp_row.ename
                             ||'-'
                             ||v_emp_row.job);
    END LOOP;
END;
/