While executing the insert statement I want only the "non-duplicate" records to get inserted, duplicate records should get excluded during insertion.
How can I do?

Option1:

INSERT INTO EMP_TARGET SELECT * FROM EMP_SOURCE
LOG ERRORS INTO ERR$_EMP_TARGET -- Error log table we have to create.
REJECT LIMIT UNLIMTED;

With above code we can insert unique data from emp_source(which has duplicate) into emp_target. Duplicate records will be inserted into error table.

Option2:
INSERT /*+ IGORE_ROW_ON_DUPKEY_INDEX(emp_target(empno))*/
into emp_target SELECT * FROM emp_source;

with above query we are giving hint to Oracle to insert only unique records into emp_target table, with this approach we cannot log duplicate records.
_________________________________________________________________
FOR VS FORALL

1. For is an iterative statement for each value vs For all is not iterative statement its a declarative statement
2. We can write any number of statement between loop and end loop vs Only one statement in for all

CREATE TABLE NAME_LIST(ENAME VARCHAR2(30));

For:

DECLARE
    TYPE emp_name_list_typ
      IS TABLE OF VARCHAR2(30);
    lv_emp_name_list EMP_NAME_LIST_TYP := Emp_name_list_typ();
BEGIN
    lv_emp_name_list.Extend(5);

    Lv_emp_name_list(1) := 'ELA';

    Lv_emp_name_list(2) := 'BAI';

    Lv_emp_name_list(3) := 'SURESH';

    FOR i IN lv_emp_name_list.first..lv_emp_name_list.last LOOP
        INSERT INTO name_list
        VALUES     (Lv_emp_name_list(i));
    END LOOP;
END;

/ 

Forall:

DECLARE
    TYPE emp_name_list_typ
      IS TABLE OF VARCHAR2(30);
    lv_emp_name_list EMP_NAME_LIST_TYP := Emp_name_list_typ();
BEGIN
    lv_emp_name_list.Extend(5);

    Lv_emp_name_list(1) := 'ELA';

    Lv_emp_name_list(2) := 'BAI';

    Lv_emp_name_list(3) := 'SURESH';

    FORALL i IN lv_emp_name_list.first..lv_emp_name_list.last 
        INSERT INTO name_list
        VALUES     (Lv_emp_name_list(i));
   
END;

/ 