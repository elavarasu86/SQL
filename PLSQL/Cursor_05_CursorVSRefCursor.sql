--cursor vs ref cursor
--1. Normal cursor is static, where as dynamic query is dynamic.

--Cursor:
DECLARE
    CURSOR lc_emp_name IS
      SELECT ename
      FROM   emp
      WHERE  deptno = 10;--static query is attached to cursor.
    lv_emp_name VARCHAR2(30);
BEGIN
    LOOP
        FETCH lc_emp_name INTO lv_emp_name;

        exit WHEN lc_emp_name%NOTFOUND;

        dbms_output.Put_line(lv_emp_name);
    END LOOP;

    CLOSE lc_emp_name;
END;

/ 

--Ref cursor:

CREATE OR replace PROCEDURE Print_list(p_in VARCHAR2)
AS
  TYPE ref_cur_type IS ref CURSOR;
  lv_ref_cur REF_CUR_TYPE;
  lv_name    VARCHAR2(30);
BEGIN
    IF p_in = 'ENAME' THEN
      OPEN lv_ref_cur FOR
        SELECT ename
        FROM   emp;
    ELSIF p_in = 'DNNAME' THEN
      OPEN lv_ref_cur FOR 'select dname from dept';
    ELSIF p_in = 'JOB' THEN
      OPEN lv_ref_cur FOR
        SELECT DISTINCT job
        FROM   emp;
    ELSE
      OPEN lv_ref_cur FOR
        SELECT 'invalid input'
        FROM   dual;
    END IF;

    LOOP
        FETCH lv_ref_cur INTO lv_name;

        exit WHEN lv_ref_cur%NOTFOUND;

        dbms_output.Put_line(lv_name);
    END LOOP;
END;

/ 


--2. Ref cursor can be returned in stored procedure this cannot be done in cursor.
-- procedure to be called
CREATE OR replace PROCEDURE proc_get_list(p_in VARCHAR2,p_out_cur out sys_refcursor)
AS
  lv_name    VARCHAR2(30);
BEGIN
    IF p_in = 'ENAME' THEN
      OPEN p_out_cur FOR
        SELECT ename
        FROM   emp;
    ELSIF p_in = 'DNNAME' THEN
      OPEN p_out_cur FOR 'select dname from dept';
    ELSIF p_in = 'JOB' THEN
      OPEN p_out_cur FOR
        SELECT DISTINCT job
        FROM   emp;
    ELSE
      OPEN p_out_cur FOR
        SELECT 'invalid input'
        FROM   dual;
    END IF;
END;

/ 
-- calling procedure
CREATE OR replace PROCEDURE Proc_print_list(p_in VARCHAR2)
AS
  TYPE lc_ref_cur_type IS ref CURSOR;
  lv_ref_cur LC_REF_CUR_TYPE;
  lv_name    VARCHAR2(30);
BEGIN
    Proc_get_list(p_in, lc_ref_cur);

    LOOP
        FETCH lc_ref_cur INTO lv_name;

        exit WHEN lc_ref_cur%NOTFOUND;

        dbms_output.Put_line(lv_name);
    END LOOP;
END;

/ 

exec Proc_print_list('ENAME');
--3. Ref cursor can be returned to client who ever calling(Java, python code).
--4. Normal cursor can be a global cursor.

CREATE OR replace PACKAGE emp_pkg
AS
  CURSOR emp_list IS
    SELECT ( from emp;

CURSOR emp_list_10 IS
  SELECT *
  FROM   emp
  WHERE  deptno=10;

CURSOR emp_list_20 IS
  SELECT *
  FROM   emp
  WHERE  deptno=20;

END emp_pkg;/


DECLARE
  lv_emp_rec emp%ROWTYPE;
BEGIN
  OPEN emp_pkg.emp_list;
  FETCH emp_pkg.emp_list
  INTO  lv_emp_rec;
  
  dbms_output.Put_line('ENAME = '
  || lv_emp_rec.ename);
  dbms_output.Put_line('SAL = '
  ||lv_emp_rec.sal);
  CLOSE emp_pkg.emp_list;
END;
/