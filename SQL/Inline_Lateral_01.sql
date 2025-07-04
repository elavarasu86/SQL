/* Purpose of using Lateral keyword is, we can use outer table columns in inline view/subquery.
*/

--Method1:
SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       AVG_SALARY
FROM DEPARTMENTS D,
  (SELECT DEPARTMENT_ID,
          ROUND(AVG(SALARY), 2) AS AVG_SALARY
   FROM EMPLOYEES E
   GROUP BY DEPARTMENT_ID) )EM
WHERE D.DEPARTMENT_ID =EM.DEPARTMENT_ID;

--Method2:
SELECT DEPARTMENT_ID,
       DEPARTMENT_NAME,
  (SELECT ROUND(AVG(SALARY), 2)
   FROM EMPLOYEES E
   WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID) AS AVG_SALARY
FROM DEPARTMENTS D;

--Method3:
SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       AVG_SALARY
FROM DEPARTMENTS D,
     LATERAL
  (SELECT DEPARTMENT_ID, ROUND(AVG(SALARY), 2) AS AVG_SALARY
   FROM EMPLOYEES E
   WHERE D.DEPARTMENT_ID=E.DEPARTMENT_ID
   GROUP BY DEPARTMENT_ID);
-------------------------------------------------DATA-------------------------------------------------
create table departments (
  department_id   number(2) constraint departments_pk primary key,
  department_name varchar2(14),
  location        varchar2(13)
);

insert into departments values (10,'ACCOUNTING','NEW YORK');
insert into departments values (20,'RESEARCH','DALLAS');
insert into departments values (30,'SALES','CHICAGO');
insert into departments values (40,'OPERATIONS','BOSTON');
commit;


create table employees (
  employee_id   number(4) constraint employees_pk primary key,
  employee_name varchar2(10),
  job           varchar2(9),
  manager_id    number(4),
  hiredate      date,
  salary        number(7,2),
  commission    number(7,2),
  department_id number(2) constraint emp_department_id_fk references departments(department_id)
);

insert into employees values (7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
insert into employees values (7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
insert into employees values (7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
insert into employees values (7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
insert into employees values (7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
insert into employees values (7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
insert into employees values (7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
insert into employees values (7788,'SCOTT','ANALYST',7566,to_date('13-JUL-87','dd-mm-rr')-85,3000,NULL,20);
insert into employees values (7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
insert into employees values (7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
insert into employees values (7876,'ADAMS','CLERK',7788,to_date('13-JUL-87', 'dd-mm-rr')-51,1100,NULL,20);
insert into employees values (7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
insert into employees values (7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
insert into employees values (7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);
commit;