FunctionBased_Index:
In function based index data is not stored as it is in the field, instead data will be converted based on function and converted value is stored in index.
Note: We can keep expression also in functionbased index.

CREATE INDEX INDEX_NAME ON EMPLOYEE(UPPER(EMPLOYEE_NAME));

For Example:

Below Index is normal B-Tree index.

RowID					Name
ROWIDFORTHISFIELDIS1	Ela
ROWIDFORTHISFIELDIS2	Steve
ROWIDFORTHISFIELDIS3	Mike
ROWIDFORTHISFIELDIS4	Richard
ROWIDFORTHISFIELDIS5	Josh

Below Index is functionbased inded on Name field.

CREATE INDEX INDEX_NAME ON EMPLOYEE(UPPER(EMPLOYEE_NAME));

RowID					Name
ROWIDFORTHISFIELDIS1	ELA
ROWIDFORTHISFIELDIS2	STEVE
ROWIDFORTHISFIELDIS3	MIKE
ROWIDFORTHISFIELDIS4	RICHARD
ROWIDFORTHISFIELDIS5	JOSH

When we query employee table with below statement performance will be good as we using function based index.

SELECT * FROM EMPLOYEE WHERE UPPER(NAME)='ELA';
