--Merge Statement

-- Let's consider we have two table one is employee_target and second one is employee_source.

emp_tgt

empno	ename		sal
1		Ravi		1000
2		Raghu		2000
3		Priya		3000
4		Kavin		4000

emp_src

empno	ename		sal
1		Ravi		1000
2		Raghu		2000
3		Priya		3000
4		Kavin		4000

-- Now both the tables are looking same. 
-- Now lets add a field and update a field in emp_src table.

emp_src

empno	ename		sal
1		Ravi		1000
2		Raghu		2000
3		Priya		3500
4		Kavin		4000
5		Suman		5000

--To replace this transaction into emp_tgt table we have to write an insert and update statement.
UPDATE emp_tgt
SET    sal = (SELECT emp_src.sal
              FROM   emp_src
              WHERE  emp_src.empno = emp_tgt.empno); 

INSERT INTO emp_tgt
SELECT empno,
       ename,
       sal
FROM   emp_src
WHERE  empno NOT IN (SELECT empno
                     FROM   emp_tgt); 
-- Also we can do this with Merge statement

MERGE INTO emp_tgt
using emp_src
ON ( emp_tgt.empno = emp_src.empno )
WHEN matched THEN
  UPDATE SET sal = emp_src.sal
WHEN NOT matched THEN
  INSERT
  VALUES (emp_src.empno,
          emp_src.ename,
          emp_src.sal); 
		  
--Next Scenario. Here we are going to see insert, update and delete transaction. Now source table have one more field.

emp_src

empno	ename		sal		Resigned
1		Ravi		1000	Y
2		Raghu		2000
3		Priya		3500
4		Kavin		4000
5		Suman		5000


MERGE INTO emp_tgt
using emp_src
ON ( emp_tgt.empno = emp_src.empno )
WHEN matched THEN
  UPDATE SET sal = emp_src.sal
  DELETE where emp_src.resigned = 'Y'
WHEN NOT matched THEN
  INSERT
  VALUES (emp_src.empno,
          emp_src.ename,
          emp_src.sal);


----Merge exception for this lets take same tables with minor change in source : Ename length is 30.

CREATE TABLE emp_src
  (
     empno NUMBER PRIMARY KEY,
     ename VARCHAR2(30),
     sal   NUMBER(5)
  ); 
  
CREATE TABLE emp_tgt
  (
     empno NUMBER PRIMARY KEY,
     ename VARCHAR2(10),
     sal   NUMBER(5)
  ); 
  
emp_tgt

empno	ename		sal
1		Ravi		1000
2		Raghu		2000
3		Priya		3000
4		Kavin		4000

emp_src

empno	ename			sal
1		Ravi			1000
2		Raghu			2000
3		Priya			3500
4		Kavin			4000
5		Suman Chandra	5000

-- as the ename length is 30 in source and 10 in target when trying to into new record into target we will get exception.

merge
INTO         emp_tgt
USING        emp_src
ON (
                          emp_tgt.empno = emp_src.empno )
WHEN matched THEN
UPDATE
SET              sal = emp_src.sal
WHEN NOT matched THEN
INSERT values
       (
              emp_src.empno,
              emp_src.ename,
              emp_src.sal
       )
       log errors
INTO   err$_emp_tgt reject limit UNLIMITED;
		  
-- error records will go into error log table and remaining transaction will continue.
