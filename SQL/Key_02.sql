--Natural Keys

--A natural key is one or more existing data attributes that are unique to the business concept. For the Customer table there was two candidate keys, in this case CustomerNumber and SocialSecurityNumber

CREATE TABLE PERSON(ID NUMBER,FIRST_NAME VARCHAR2(20),
LAST_NAME VARCHAR2(20),
ADDRESS VARCHAR2(50),
COLUMN1 VARCHAR2(10),
COLUMN2 VARCHAR2(10),
COLUMN3 VARCHAR2(10),
COLUMN4 VARCHAR2(10));

-- In above person table Natural key will be FIRST_NAME, LAST_NAME and ADDRESS fields as these three fields uniquely finds the person.