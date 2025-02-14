/*
BitMap Index:
When cardinality is low we have to use bitmap Index. 
For Example in Employee table we can create bitmap Index on Department_ID.
*/

CREATE BITMAP INDEX INDEX_NAME ON EMPLOYEE(Department_ID);

Disadvantage:
When there is more number of DML Operations, Oracle locks the all rows with points to same key.
For Example:
In Employee table for Department_ID 100 we can 5 records. If I update one record out of 5 records with department_ID as 100 all 5 records will be locked. Other transaction on department_ID 100 will be done after commit or rollback.