--SQL to delete duplicate records.

INSERT INTO EMP_T VALUES(101,'KING','PRESIDENT',100000,10);
INSERT INTO EMP_T VALUES(102,'RAGHU','MANAGER',80000,10);
INSERT INTO EMP_T VALUES(102,'RAGHU','MANAGER',80000,10);
INSERT INTO EMP_T VALUES(103,'FORD','MANAGER',75000,10);
INSERT INTO EMP_T VALUES(104,'JAMES','MANAGER',82000,30);
INSERT INTO EMP_T VALUES(104,'JAMES','MANAGER',82000,30);
INSERT INTO EMP_T VALUES(104,'JAMES','MANAGER',82000,30);
INSERT INTO EMP_T VALUES(105,'WARD','SALESMAN',50000,10);
INSERT INTO EMP_T VALUES(106,'FORD','SALESMAN',40000,10);
INSERT INTO EMP_T VALUES(107,'SMITH','SALESMAN',45000,10);

--Above data has duplicate records 102 and 104 has duplicate.
--Option1:

DELETE FROM emp_t
WHERE  ROWID NOT IN (SELECT Max(ROWID)
                     FROM   emp_t
                     GROUP  BY empno,
                               ename,
                               job,
                               sal,
                               deptno); 
							   
--Option2:

DELETE FROM emp_t a
WHERE  ROWID > (SELECT Min(ROWID)
                FROM   emp_t b
                WHERE  a.empno = b.empno
                       AND a.ename = b.ename
                       AND a.job = b.job
                       AND a.sal = b.sal
                       AND a.deptno = b.deptno);
					   
--Option3:

DELETE FROM emp_t
WHERE  ROWID IN (SELECT r1
                 FROM   (SELECT empno,
                                ename,
                                job,
                                sal,
                                deptno,
                                ROWID                r1,
                                Row_number()
                                  over(
                                    PARTITION BY empno, ename, job, sal, deptno
                                    ORDER BY ROWNUM) R
                         FROM   emp_t
                         ORDER  BY empno)
                 WHERE  r > 1); 