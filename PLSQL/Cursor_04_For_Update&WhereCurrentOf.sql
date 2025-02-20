FOR UPDATE:
Is used to lock the rows. When a for update clause added to a cursor no other transaction can do update/delete/truncate transaction on those records.

For example:
DECLARE
    CURSOR emp_name_list IS
      SELECT empno
      FROM   emp
      WHERE  deptno = 10;
    v_empno NUMBER;
BEGIN
    OPEN emp_name_list;

    LOOP
        FETCH emp_name_list INTO v_empno;

        exit WHEN emp_name_list%NOTFOUND;

        dbms_output.Put_line('updating employee '
                             ||v_empno);

        UPDATE emp
        SET    sal = sal + 100
        WHERE  empno = v_empno;-- when another user deletes these records while executing this then zero records will be updated. In this code we don't have control to lock the rows.

        dbms_output.Put_line('No of rows updated ='
                             ||SQL%rowcount);
    END LOOP;

    CLOSE emp_name_list;
END;

/ 

--for update
DECLARE
    CURSOR emp_name_list IS
      SELECT empno
      FROM   emp
      WHERE  deptno = 10 FOR UPDATE;-- by adding for update we are locking the rows no other user can run delete or update on this records.
    v_empno NUMBER;
BEGIN
    OPEN emp_name_list;

    LOOP
        FETCH emp_name_list INTO v_empno;

        exit WHEN emp_name_list%NOTFOUND;

        dbms_output.Put_line('updating employee '
                             ||v_empno);

        UPDATE emp
        SET    sal = sal + 100
        WHERE  empno = v_empno;-- when another user deletes these records while executing this then zero records will be updated. In this code we don't have control to lock the rows.

        dbms_output.Put_line('No of rows updated ='
                             ||SQL%rowcount);
    END LOOP;

    CLOSE emp_name_list;
END;

/ 

*************************
WHERE CURRENT OF:
We can use this clause as like where clause. This clause should be used only with FOR UPDATE clause.

For example:

DECLARE
    CURSOR emp_name_list IS
      SELECT empno
      FROM   emp
      WHERE  deptno = 10;
    v_empno NUMBER;
BEGIN
    OPEN emp_name_list;

    LOOP
        FETCH emp_name_list INTO v_empno;

        exit WHEN emp_name_list%NOTFOUND;

        dbms_output.Put_line('updating employee '
                             ||v_empno);

        UPDATE emp
        SET    sal = sal + 100;-- Here I am not using where clause, in this case update will be applied on all the records. To over come this issue. see below code.

        dbms_output.Put_line('No of rows updated ='
                             ||SQL%rowcount);
    END LOOP;

    CLOSE emp_name_list;
END;

/ 

above code can be re-written like below one.

DECLARE
    CURSOR emp_name_list IS
      SELECT empno
      FROM   emp
      WHERE  deptno = 10;
    v_empno NUMBER;
BEGIN
    OPEN emp_name_list;

    LOOP
        FETCH emp_name_list INTO v_empno;

        exit WHEN emp_name_list%NOTFOUND;

        dbms_output.Put_line('updating employee '
                             ||v_empno);

        UPDATE emp
        SET    sal = sal + 100
		WHERE CURRENT OF emp_name_list;-- This condition will only update one record in this case, as cursor will have one value in it.

        dbms_output.Put_line('No of rows updated ='
                             ||SQL%rowcount);
    END LOOP;

    CLOSE emp_name_list;
END;

/ 