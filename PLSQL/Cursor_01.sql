CURSOR:

A cursor is a pointer to a private SQL area that stores information about processing a specif select or DML statement.
(Points to a memory location where data is stored.)

Implicit CURSOR:
Constructed and managed by Oracle. User cannot control it.

Explicit CURSOR:
Created and managed by user. Declares, open, fetch and close the cursor.

    Types:
    1. Named Cursor
    2. Ref Cursor
    3. For Cursor

Why we need cursor?

set serveroutput ON
DECLARE
    v_name VARCHAR2(100);
BEGIN
    SELECT empname
    INTO   v_name
    FROM   employee
    WHERE  empnumber = 100;

    dbms_output.Put_line('Employee Name is '
                         ||v_name);
END;

/ 

In the above code we have variable called "v_name",it holds employee name of employee number 100. If we remove where clause above statement will fail with "More than one records" error.

To hold more than one value or list of value we use cursor. We can do that with nested table.

set serveroutput ON
DECLARE
    TYPE lv_name_list_type
      IS TABLE OF VARCHAR2(100);
    lv_name_list LV_NAME_LIST_TYPE := Lv_name_list_type();
BEGIN
    SELECT ename
    bulk   collect INTO lv_name_list
    FROM   emp;

    FOR i IN lv_name_list.first..lv_name_list.last LOOP
        dbms_output.Put_line(Lv_name_list(i));
    END LOOP;
END;

/ 

Using CURSOR:

set serveroutput ON
DECLARE
    CURSOR emp_name_list IS
      SELECT ename
      FROM   emp;
    v_name VARCHAR2(100);
BEGIN
    OPEN emp_name_list;--Named location of the memory.

    LOOP
        FETCH emp_name_list INTO v_name;

        exit WHEN emp_name_list%NOTFOUND;

        dbms_output.Put_line(v_name);
    END LOOP;

    CLOSE emp_name_list;
END;

/ 

Note: Below system table helps us to understand more about cursor.

select * from V$OPEN_CURSOR;

select * from V$PARAMETER;
******************************************************************

What is cursor attributes? Explain cursor attributes.

1. ISOPEN	-- Returns True if cursor is open, False otherwise.
2. FOUND	-- Information about fetch statement. 
3. NOTFOUND	-- Information about fetch statement. 
4. ROWCOUNT	-- Returns number of records fetched from cursor at that point in time.

for implicit cursor we use "SQL"%cursor attributes 

Example:
SQL%ISOPEN
SQL%ROWCOUNT

for explicit cursor we use cursor name and cursor attributes.

Example
cursorname%ISOPEN



