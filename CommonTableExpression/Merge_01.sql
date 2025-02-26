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