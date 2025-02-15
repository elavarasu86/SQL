--Question1
Write a query to select the rows that have "A" in any one of the columns(col1,col2,col3) without using "OR" Keyword.

Table:
S.no	col1	col2	col3
1		A		B		C
2				A		B
3		E				
4				A		E
5		E		D		C

Solution1:
select * from table_name where col1='A' OR col2='A' OR col3='A';

Solution2:
select * from table_name where col1='A' union all
select * from table_name where col2='A' union all
select * from table_name where col3='A';

Solution3:
select * from table_name where 'A' in (col1,col2,col3);

Solution4:
Select * from table_name where col1||col2||col3 like '%A%'; /* Here we are concatenating column value and using like operatior.*/

Solution5:
Select * from table_name where instr(col1||col2||col3,'A')>0;

--Question2
Write an SQL statement to select employees getting salary greater than average salary of their department that they are working in.

Table: EMPLOYEE
EMPNO	ENAME		JOB			MGR		HIREDATE	SAL		COMM	DEPTNO
7839	KING		PRESIDENT			17-NOV-81	5100			10
7698	CHRIS		MANAGER		7839	01-OCT-84	2850			30

Solution1: Using With statement
WITH AVG_SAL AS (
SELECT AVG(SAL) AS AVG_S,DEPTNO FROM EMPLOYEE GROUP BY DEPTNO
)SELECT * FROM EMPLOYEE EMP,AVG_SAL ASL
WHERE EMP.DEPTNO=ASL.DEPTNO AND EMP.SAL >AVG_S

Solution2: Correlated SUB query
SELECT * FROM EMP A WHERE A.SAL > (SELECT AVG(B.SAL) FROM EMP B WHERE A.DEPTNO=B.DEPTNO);

Solution3: Using Analytical function
SELECT * FROM (
SELECT EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO,
AVG(SAL) OVER(PARTITION BY DEPTNO) AVG_SAL
FROM EMP)
WHERE SAL> AVG_SAL;

Solution4: Using function within with class
WITH
	FUNCTION AVG_SAL(P_DEPTNO NUMBER) RETURN NUMBER AS
	V_AVG_SAL NUMBER;
	BEGIN
		SELECT AVG(SAL)
		INTO V_AVG_SAL
		FROM EMP
		WHERE DEPTNO=P_DEPTNO;
		
		RETURN V_AVG_SAL;
	END AVG_SAL;
SELECT EMPNO,ENAME,JOB,MGR_SAL,DEPTNO
FROM EMP
WHERE SAL > AVG_SAL(DEPTNO);
/
