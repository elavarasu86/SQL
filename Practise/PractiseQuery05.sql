Question5:
--Write a query to print number from 1..to "n" numbers

SELECT ROWNUM,
       LEVEL
FROM   dual
CONNECT BY LEVEL <= 15; 

Solution2:

CREATE OR replace FUNCTION Fn_get_table_of_numbers(p_count NUMBER)
RETURN sys.odcinumberlist
IS
  l_num_tab sys.odcinumberlist := sys.Odcinumberlist();
BEGIN
    FOR i IN 1..p_count LOOP
        l_num_tab.extend;

        L_num_tab(l_num_tab.last) := i;
    END LOOP;

    RETURN l_num_tab;
END fn_get_table_of_numbers;

/
SELECT *
FROM   TABLE(Fn_get_table_of_numbers(10)); 

Solution3:
WITH 
	FUNCTION fn_get_table_of_numbers(p_count number)
		RETURN sys.odcinumberlist 
	IS 
		l_num_tab sys.odcinumberlist := sys.odcinumberlist();
	BEGIN
		for i IN 1..p_count
		loop 
			l_num_tab.extend;
			l_num_tab(l_num_tab.last):=i;
		end LOOP;
		RETURN l_num_tab;
	END fn_get_table_of_numbers;
SELECT * FROM   Table(Fn_get_table_of_numbers(10));

Solution4:
WITH t1(id)
     AS (SELECT 1 id
         FROM   dual
         UNION ALL
         SELECT id + 1
         FROM   t1
         WHERE  id < 10)
SELECT id
FROM   t1; 

Solution5:
SELECT rownum
FROM  (
                SELECT   1 number
                FROM     dual
                GROUP BY cube(1,2,3,4)
                where    rownum<=10;
				
Solution6:
SELECT   r_num
FROM     dual model dimension BY (0 r_dim) measures (0 r_num) rules iterate(10) ( r_num[iteration_number] =iteration_number+1)
ORDER BY 1;

Solution7:
SELECT rownum
FROM   Xmltable('1 to 10'); 