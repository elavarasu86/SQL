Mutating Trigger:
A DML statement which triggers a trigger, wherein in the trigger a select or update statement is done in the trigger body.


CREATE TABLE emp_t
  (
     empno  NUMBER PRIMARY KEY,
     ename  VARCHAR2(100),
     deptno NUMBER,
     job    VARCHAR2(10),
     sal    NUMBER
  );

CREATE TABLE emp_sal_log
  (
     empno      NUMBER,
     update_log VARCHAR2(1000)
  ); 
  
insert into emp_t values(1000,'KING',10,'CEO',150000);
insert into emp_t values(1001,'RAVI',10,'MANAGER',60000);
insert into emp_t values(1002,'SURYA',10,'LEAD',50000);
insert into emp_t values(1003,'RAGHU',10,'DEVELOPER',40000);
insert into emp_t values(1004,'SCOTT',10,'QA',40000);

CREATE OR replace TRIGGER trig_sal
  BEFORE UPDATE OF sal ON emp_t
  FOR EACH ROW
DECLARE
    lv_max_sal NUMBER := 100000;
BEGIN
    IF :new.sal < lv_max_sal THEN
      INSERT INTO emp_sal_log
      VALUES     (:new.empno,
                  'salary updates successfully : '
                  ||'OLD SAL = '
                  ||:old.sal
                  ||', NEW SAL = '
                  ||:new.sal);
    ELSE
      :new.sal := :old.sal;

      INSERT INTO emp_sal_log
      VALUES     (:new.empno,
                  'Salary NOT UPDATED : Employee salary cannot be more than '
                  ||lv_max_sal);
    END IF;
END;

/ 

-- In the above trigger we are updating emp_t table if new salary field value is less than 1,00,000. Else we are updating with old value only.

-- In below trigger we are making sure new salary field value is less than CEO salary. and CEO new salary value can be anything.

--Below trigger will have mutating trigger.

CREATE OR replace TRIGGER trig_sal
  BEFORE UPDATE OF sal ON emp_t
  FOR EACH ROW
DECLARE
    lv_ceo_sal NUMBER;
BEGIN
    SELECT sal
    INTO   lv_ceo_sal
    FROM   emp_t
    WHERE  job = 'CEO'
           AND deptno = :new.deptno;

    IF ( :new.sal < lv_ceo_sal
         AND :old.job <> 'CEO' )
        OR ( :old.job = 'CEO' ) THEN
      INSERT INTO emp_sal_log
      VALUES      (:new.empno,
                   'salary updated successfully :'
                   ||'OLD SAL = '
                   ||:old.sal
                   ||', NEW SAL = '
                   ||:new.sal);
    ELSE
      :new.sal := :old.sal;

      INSERT INTO emp_sal_log
      VALUES      (:new.empno,
                   'Salary NOT UPDATED : Employee salary cannot be more than '
                   ||lv_ceo_sal);
    END IF;
END;

/ 
***************************************
/*How to avoid mutating trigger:

Mutating trigger will happen on row level trigger not on statement level trigger.

so above piece of code is changed as below.*/

--Creating a package to hold global variable.

CREATE OR replace PACKAGE pkg1
AS
  lv_ceo_sal NUMBER;
END;

/ 

--Creating a Statement level trigger to avoid mutating trigger.

CREATE OR replace TRIGGER trig_before_up_sal
  BEFORE UPDATE OF sal ON emp_t
DECLARE
    lv_max_sal NUMBER;
BEGIN
    SELECT sal
    INTO   pkg1.lv_ceo_sal
    FROM   emp_t
    WHERE  job = 'CEO';
END;

/ 

-- Changed Row level trigger
CREATE OR replace TRIGGER trig_sal
  BEFORE UPDATE OF sal ON emp_t
  FOR EACH ROW
DECLARE
    lv_ceo_sal NUMBER;
BEGIN

    IF ( :new.sal < pkg1.lv_ceo_sal
         AND :old.job <> 'CEO' )
        OR ( :old.job = 'CEO' ) THEN
      INSERT INTO emp_sal_log
      VALUES      (:new.empno,
                   'salary updated successfully :'
                   ||'OLD SAL = '
                   ||:old.sal
                   ||', NEW SAL = '
                   ||:new.sal);
    ELSE
      :new.sal := :old.sal;

      INSERT INTO emp_sal_log
      VALUES      (:new.empno,
                   'Salary NOT UPDATED : Employee salary cannot be more than '
                   ||lv_ceo_sal);
    END IF;
END;

/ 
