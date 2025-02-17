--Type of exceptions:
1. predefined exception/System Defined
	1. Named Exception -- Exception that containe Exception name, Number and description
		Example: Ora-00001 Primary Key exception
		
DECLARE
    v_num NUMBER;
BEGIN
    -- In below statement if empno already present in table we will get primary key violation exception
    INSERT INTO emp
                (empno)
    VALUES     (7777);

    --In below statement divide by zero exception will be raised.
    v_num := 1 / 0;
EXCEPTION
    WHEN dup_val_on_index THEN
      dbms_output.Put_line('Emp no already available');
    WHEN zero_divide THEN
      dbms_output.Put_line('Trying to divide by zero');
    WHEN other THEN
      dbms_output.Put_line('Other exception');
END;

/ 	
		
	2. Un-Named Exception -- Exception that containe name and description
		--In the above example code if employee number field is defined as two bytes then we will get ora-01438 error, which does not have name.

2. User Defined Exception

DECLARE
v1 number:=10;
v2 number:=0;
v_result number;
v_excp exception;
BEGIN
if v2=0 then
raise v_excp;
end if 
v_result := v1/v2;
exception when v_excp then
dbms_output.put_line('User is raising this exception');
end;
/

