SQL Loader:
	
	Is a utility provided by oracle to load data from external files into Oracle database.
	Command line utility
	
	Oracle need control file: Information about source file, also metadata info about source file.
	Example: source file name, target file name and delimiter.
	
	While loading the data into target table, SQL loader generated below files:
		1. Log File( Contain information about process logs)
		2. Bad file( Contain information about failed data)
		3. Discard file(Contain information about rejected data)
		
Sample control file statement:

Option(skip=1) /*This will skip first record in the data file*/
LOAD data
INFILE 'Sample_data.txt'
DISCARDFILE 'Sample_data_discarded.txt'
TRUNCATE INTO TABLE emp_details /*If this statement is not mention Oracle by default truncate's the table. If you want to append data then we have to use Append keywork*/
when dept_no="10" /*This statement help us to load data which has dept number as 10 rest of the value will not be loaded to target table.*/
	FIELDS TERMINATED BY ','
	(emp_name,
	emp_job,
	emp_sal,
	dept_no)
	
SQL loader comman:
sqlldr devuser2/devuser2@orclpdb control=control_file.ctl

************************************************************
ExternalTable:
	
External table is another way to load data from a file into Oracle.

Table will not hold any information(Data), instead it will hit and fetch records from file when we use external table in our queries.

Before creating external table we have to create directory object in Oracle database.

CREATE directory external_data_directory AS 'C:/Oracle/'; 

CREATE TABLE table_name_employee
  (
     empno  NUMBER(4),
     ename  VARCHAR2(10),
     deptno NUMBER(2)
  ) organization external( TYPE oracle_loader DEFAULT directory
external_data_directory ACCESS parameters( records delimited BY newline fields
terminated BY ',') location('filename.txt'); 

select * from table_name_employee;

In-line external table:
We don't have to create table instead we can give all the info as part of select clause.
Note: External Table can be used only from the machine where Oracle is installed not from client system.
