--View Question:

--Force View:

-- what if we create a view without base table.

--for example:

CREATE OR REPLACE VIEW STUDENT_VIEW AS 
SELECT * FROM STUDENT;

-- Consider that STUDENT table is not created, but above script was executed in that case we will face error from oracle. There are some scenarios where we will create underlying table will be created later but we need to create view now.

CREATE OR REPLACE FORCE VIEW STUDENT_VIEW AS 
SELECT * FROM STUDENT;

-- Still we will get compilation error, but view will be created

-----------------------------------------------------------------
--View "WITH READ ONLY " CONSTRAINTS
-- If you want to only ready from the view and avoid DML operation(like insert) on view.

CREATE OR REPLACE  VIEW STUDENT_VIEW AS 
SELECT * FROM STUDENT WITH READ ONLY;


-----------------------------------------------------------------
--View "WITH CHECK ONLY " CONSTRAINTS

CREATE OR REPLACE VIEW STUDENT_VIEW_ECE AS 
SELECT * FROM STUDENT WHERE DEPT='ECE';

-- As part of above statement we can insert data into STUDENT table via view.  for example
INSERT INTO STUDENT_VIEW_ECE VALUES ( 100,'KUMAR','EEE');

-- In above insert statement I am inserting a record which is not of ECE department.
-- If you want to restrict everyone to do DML operation only for the where clause mentioned in view;

CREATE OR REPLACE VIEW STUDENT_VIEW_ECE As
SELECT * FROM STUDENT WHERE DEPT = 'ECE' 
WITH CHECK OPTION;-- with check option, we can do DML opertion based on where clause;

INSERT INTO STUDENT_VIEW_ECE VALUES ( 100,'KUMAR','ECE');