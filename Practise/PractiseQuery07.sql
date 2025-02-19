Write a sql to compute the group salary of all the employees.

Group salary = Sum of salary of all employees reporting under him including his own slary.

CREATE TABLE emp_t
  (
     empno NUMBER,
     ename VARCHAR2(100),
     mgr   NUMBER,
     sal   NUMBER
  ); 
  
insert into emp_t (empno,ename,mgr,sal) values(7839,'KING',NULL,1000);
insert into emp_t (empno,ename,mgr,sal) values(7698,'BLAKE',7839,700);
insert into emp_t (empno,ename,mgr,sal) values(7782,'CLARK',7839,500);
insert into emp_t (empno,ename,mgr,sal) values(7566,'JONES',7839,800);
insert into emp_t (empno,ename,mgr,sal) values(7788,'SCOTT',7566,200);
insert into emp_t (empno,ename,mgr,sal) values(7902,'FORD',7566,100);
insert into emp_t (empno,ename,mgr,sal) values(7369,'SMITH',7902,75);
insert into emp_t (empno,ename,mgr,sal) values(7499,'ALLEN',7698,100);
insert into emp_t (empno,ename,mgr,sal) values(7521,'WARD',7698,200);
insert into emp_t (empno,ename,mgr,sal) values(7654,'MARTIN',7698,150);
insert into emp_t (empno,ename,mgr,sal) values(7844,'TURNER',7698,150);
insert into emp_t (empno,ename,mgr,sal) values(7876,'ADAMS',7788,50);
insert into emp_t (empno,ename,mgr,sal) values(7900,'JAMES',7698,100);
insert into emp_t (empno,ename,mgr,sal) values(7934,'MILLER',7782,300);
COMMIT;

SELECT *
FROM   emp_t
CONNECT BY PRIOR empno = mgr; 


SELECT empno,
       ename,
       mgr,
       sal,
       Sys_connect_by_path(ename, '-->')
FROM   emp_t
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr; 


OPTION1:
SELECT empno,
       ename,
       mgr,
       sal,
       (SELECT SUM(sal)
        FROM   emp_t
        START WITH ename = A.ename
        CONNECT BY PRIOR empno = mgr) GROUP_SAL
FROM   emp_t A; 

OPTION2:
CREATE OR replace FUNCTION Get_group_sal(pin_ename VARCHAR2)
RETURN NUMBER
AS
  lv_grp_sal NUMBER;
BEGIN
    SELECT SUM(sal)
    INTO   lv_grp_sal
    FROM   emp_t
    START WITH ename = pin_ename
    CONNECT BY PRIOR empno = mgr;

    RETURN lv_grp_sal;
END;

/ 

SELECT EMPNO,ENAME,MGR,SAL,Get_group_sal(A.ENAME) GROUP_SAL 
FROM EMP_T A;

OPTION3:
WITH
FUNCTION fn_group_sal( pin_ename VARCHAR)
  RETURN NUMBER AS lv_grp_sal NUMBER;BEGIN
    SELECT SUM(sal)
    INTO   lv_grp_sal
    FROM   emp_t
           START WITH ename =pin_ename
           CONNECT BY PRIOR empno =mgr;
    
    RETURN lv_grp_sal;
  END;
  
SELECT empno,
         ename,
         mgr,
         sal,
         fn_group_sal(ename) group_sal
  FROM   emp_t a;
