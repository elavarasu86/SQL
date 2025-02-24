DML Trigger: Statement level trigger will be executed only once whereas row level trigger will be executed for each row.
Two type of DML triggers 
	1. Row Level Trigger
	2. Statement Level Trigger

Order of DML trigger execution is below:
1. Statement level BEFORE
2. Row level BEFORE
<<Table transaction>>
3. Row level After
4. Statement level After
	
Row Level Trigger:

CREATE OR REPLACE TRIGGER TRIGGER_NAME 
BEFORE INSERT ON STUDENT FOR EARCH Row
BEGIN
DBMS_OUTPUT.PUT_lINE("Output Statement");
END;
/

CREATE OR REPLACE TRIGGER TRIGGER_NAME 
AFTER INSERT ON STUDENT FOR EARCH Row
BEGIN
DBMS_OUTPUT.PUT_lINE("Output Statement");
END;
/

	1. Insert (Before/After)
	2. Update (Before/After)
	3. Delete (Before/After)

Statement Level Trigger:

CREATE OR REPLACE TRIGGER TRIGGER_NAME 
BEFORE INSERT ON STUDENT 
BEGIN
DBMS_OUTPUT.PUT_lINE("Output Statement");
END;
/

CREATE OR REPLACE TRIGGER TRIGGER_NAME 
AFTER INSERT ON STUDENT 
BEGIN
DBMS_OUTPUT.PUT_lINE("Output Statement");
END;
/

	1. Insert (Before/After)
	2. Update (Before/After)
	3. Delete (Before/After)

Can we create same type of trigger on a table. yes we can do that.
	If you create same type of trigger on a table, Oracle does not follow any specific order to execute the triggers, if developer has complelling reason then we can
instruct Oracle to follow developer mentioned order. Use below keyword to do so.

	"Follow trigger_name_To_Be_Followed".
