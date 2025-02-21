/*
Compund Trigger:
Combines the following triggers into one single trigger;
1. Before Statement Trigger
2. Before Row Trigger
3. After Row Trigger
4. After Statement Trigger

We can skip an kind of trigger its not mandatory to keep all 4 type of triggers*/

CREATE
OR
replace TRIGGER emp_comp_trigger FOR INSERT
OR
UPDATE
OR
DELETE
ON emp COMPOUND TRIGGER
       --global variable
       g_variable VARCHAR2(50):= 'DEMO ON COMPOUND TRIGGER';

BEFORE STATEMENT
IS
  --local variable
  l_variable VARCHAR2(50) := 'BEFORE STATEMENT';
BEGIN
  dbms_output.put_line(l_variable
  ||g_variable);
END BEFORE STATEMENT BEFORE EACH ROW
IS
  l_variable VARCHAR2(50):= 'Before each row';
BEGIN
  dbms_output.put_line(l_variable
  ||g_variable);
END BEFORE EACH ROW;
AFTER EACH ROW
IS
  l_variable VARCHAR2(50):= 'After each row';
BEGIN
  dbms_output.put_line(l_variable
  ||g_variable);
END AFTER EACH ROW;
AFTER STATEMENT
IS
  --local variable
  l_variable VARCHAR2(50) := 'AFTER STATEMENT';
BEGIN
  dbms_output.put_line(l_variable
  ||g_variable);
END AFTER STATEMENT
END emp_comp_trigger;/

--Helps avoid mutating trigger.