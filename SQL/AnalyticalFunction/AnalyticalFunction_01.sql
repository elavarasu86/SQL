Analytic Functions: https://oracle-base.com/articles/misc/analytic-functions

--Finding average of salary can be done by below query. With this query we get average of whole table.

SELECT AVG(sal)
FROM   emp;
--Below query helps us to find department wise average salary.
SELECT deptno, AVG(sal)
FROM   emp
GROUP BY deptno
ORDER BY deptno;
--In both cases, the aggregate function reduces the number of rows returned by the query.

--Analytic functions also operate on subsets of rows, similar to aggregate functions in GROUP BY queries, but they do not reduce the number of rows returned by the query. For example, the following query reports the salary for each employee, along with the average salary of the employees within the department.

SELECT empno, deptno, sal,
       AVG(sal) OVER (PARTITION BY deptno) AS avg_dept_sal
FROM   emp;

--Analytic Function Syntax

/*
analytic_function([ arguments ]) OVER (analytic_clause)

The analytic_clause breaks down into the following optional elements.

[ query_partition_clause ] [ order_by_clause [ windowing_clause ] ]
*/

--query_partition_clause
--The query_partition_clause divides the result set into partitions, or groups, of data. The operation of the analytic function is restricted to the boundary imposed by these partitions, similar to the way a GROUP BY clause affects the action of an aggregate function. If the query_partition_clause is omitted, the whole result set is treated as a single partition. The following query uses an empty OVER clause, so the average presented is based on all the rows of the result set.

--order_by_clause
--The order_by_clause is used to order rows, or siblings, within a partition. So if an analytic function is sensitive to the order of the siblings in a partition you should include an order_by_clause. The following query uses the FIRST_VALUE function to return the first salary reported in each department. Notice we have partitioned the result set by the department, but there is no order_by_clause.

--Examples:
SELECT EMPNO,
       DEPTNO,
       SAL,
       AVG(SAL) OVER(PARTITION BY DEPTNO) AS AVERAGE
FROM EMP;

SELECT EMPNO,
       DEPTNO,
       SAL,
       AVG(SAL) OVER(PARTITION BY DEPTNO) AS AVERAGE,
       RANK() OVER(PARTITION BY DEPTNO
                   ORDER BY SAL DESC) AS RNK
FROM EMP;
--windowing_clause
--We have seen previously the query_partition_clause controls the window, or group of rows, the analytic operates on. The windowing_clause gives some analytic functions a further degree of control over this window within the current partition, or whole result set if no partitioning clause is used. The windowing_clause is an extension of the order_by_clause and as such, it can only be used if an order_by_clause is present. The windowing_clause has two basic forms, with a third form added in Oracle 21c.

RANGE BETWEEN start_point AND end_point
ROWS BETWEEN start_point AND end_point
GROUPS BETWEEN start_point AND end_point (21c onward)


--Below query works differently you could see by running the below query. Row and Range work differently.
SELECT empno,
       deptno,
       sal,
       AVG(sal) OVER (PARTITION BY deptno
                      ORDER BY sal RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_avg,
       AVG(sal) OVER (PARTITION BY deptno
                      ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rows_avg
FROM emp;



SELECT empno,
       deptno,
       sal,
       FIRST_VALUE(sal) OVER (
                              ORDER BY sal ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS previous_sal,
       LAST_VALUE(sal) OVER (
                             ORDER BY sal ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sal
FROM emp;
-------------------------------------------------DATA-------------------------------------------------
CREATE TABLE emp (
  empno    NUMBER(4) CONSTRAINT pk_emp PRIMARY KEY,
  ename    VARCHAR2(10),
  job      VARCHAR2(9),
  mgr      NUMBER(4),
  hiredate DATE,
  sal      NUMBER(7,2),
  comm     NUMBER(7,2),
  deptno   NUMBER(2)
);

INSERT INTO emp VALUES (7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO emp VALUES (7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO emp VALUES (7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO emp VALUES (7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO emp VALUES (7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO emp VALUES (7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO emp VALUES (7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO emp VALUES (7788,'SCOTT','ANALYST',7566,to_date('13-JUL-87','dd-mm-rr')-85,3000,NULL,20);
INSERT INTO emp VALUES (7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO emp VALUES (7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO emp VALUES (7876,'ADAMS','CLERK',7788,to_date('13-JUL-87', 'dd-mm-rr')-51,1100,NULL,20);
INSERT INTO emp VALUES (7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO emp VALUES (7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO emp VALUES (7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);
COMMIT;