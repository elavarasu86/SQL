--Oracle Table Function:


CREATE OR REPLACE TYPE T_NUM_LIST IS
TABLE OF NUMBER;
/

SELECT * FROM TABLE(T_NUM_LIST(1,2,3,4,5));

SELECT * FROM T_NUM_LIST(1,2,3,4,5);

-- A function return a collection that will behave as a data source(just like a table);
-- For example

CREATE OR REPLACE TYPE T_ENAME_LIST IS TABLE OF VARCHAR2(30);

CREATE OR replace FUNCTION Fn_get_ename_list
RETURN T_ENAME_LIST
AS
  lv_ename_list T_ENAME_LIST := T_ename_list();
BEGIN
    FOR i IN (SELECT ename
              FROM   emp) 
	LOOP
        lv_ename_list.extend;

        Lv_ename_list(lv_ename_list.last) := i.ename;
    END LOOP;

    RETURN lv_ename_list;
END;

/ 

--Fn that return collection can be used in sql queries that behaves like relational table.
-------------------------------------
-- Oracle Pipelined function.

--Table function loads all the values into collection, and finally the collection would be returned to caller.
--Pipelined function returns the value as and when the value is ready to send back caller.

CREATE OR REPLACE TYPE T_ENAME_LIST IS TABLE OF VARCHAR2(30);

CREATE OR replace FUNCTION Fn_get_ename_list
RETURN T_ENAME_LIST PIPELINED --PIPELINED is the keyword.
AS
  lv_ename_list T_ENAME_LIST := T_ename_list();
BEGIN
    FOR i IN (SELECT ename
              FROM   emp) 
	LOOP
		pipe row(i.ename);
        
    END LOOP;

    RETURN ; -- return statement here is to return the control back to caller.
END;

/ 


select * from Fn_get_ename_list();