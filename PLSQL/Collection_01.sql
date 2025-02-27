Oracle Data Types:

Scalar Data types: Will hold only one value.

NUMBER, PLS_INTEGER, BINARY_FLOAT, BINARY_DOUBLE
CHAR,VARCHAR2,NCHAR,NVARCHAR2
RAW
BOOLEAN
BLOB,CLOB,NCLOB
DATE,TIMESTAMP

Composite Data Type: Can hold more than one value of declared type.
RECORD -- One row of a data for example holding employee row.
	1. type
	2. %rowtype
COLLECTION -- Similar to Array
	1. Varray
	2. Nested Table
	3. Associative array
Reference Data Type:like ref cursor

Scalar Data type:

DECLARE
  v_emp_name VARCHAR2(10);
  v_emp_sal  NUMBER;
BEGIN
  SELECT ename,
         sal
  INTO   v_emp_name,
         v_emp_sal
  FROM   emp
  WHERE  empno=5;
  
  dbms_output.Put_line('EMP NAME = '
  || v_emp_name);
  dbms_output.Put_line('EMP SAL = '
  || v_emp_sal);
END;
/


Composite Data Type;

DECLARE
  v_emp_rec emp%rowtype;
BEGIN
  SELECT *
  INTO   v_emp_rec
  FROM   emp
  WHERE  empno=5;
  
  dbms_output.Put_line('EMP NAME = '
  || v_emp_rec.ename);
  dbms_output.Put_line('EMP SAL = '
  || v_emp_rec.sal);
END;
/

--What is COLLECTION
-- A collection is an ordered group of logically related elements. for example : List of employees Name.

--%ROWTYPE
-- We have to declare structure definition. As part of structure definition we have to mention list of value that we are going to hold.

DECLARE
  v_emp_rec emp%rowtype;
BEGIN
  SELECT *
  INTO   v_emp_rec
  FROM   emp
  WHERE  empno=5;
  
  dbms_output.Put_line('EMP NAME = '
  || v_emp_rec.ename);
  dbms_output.Put_line('EMP SAL = '
  || v_emp_rec.sal);
END;
/

-- We can hold cursor values also.

DECLARE
  CURSOR c1 IS
    SELECT empno,
           ename,
           job,
    from   emp;

lv_emp_rec c1%ROWTYPE;
BEGIN
  OPEN c1;
  FETCH c1
  INTO  lv_emp_rect;
  
  CLOSE c1;
  dbms_output.Put_line('NAME = '
  ||lv_emp_rec.ename);
END;/
