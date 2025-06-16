Hierarchical Queries

/*If a table contains hierarchical data, then you can select rows in a hierarchical order using the hierarchical query clause:

condition can be any condition as described in Conditions.

START WITH specifies the root row(s) of the hierarchy.

CONNECT BY specifies the relationship between parent rows and child rows of the hierarchy.*/

Example1:

SELECT addr_id,
       cnty,
       LEVEL,--Pseudocolumn 
       connect_by_isleaf --Pseudocolumn 
FROM plcy_addr
START WITH addr_id =1234 -- when can start from any point as root
CONNECT BY PRIOR addr_id = rlt_entity_id -- Prior can be used at any side. PRIOR refer to prior row.

Example2:

SELECT LEVEL
FROM dual CONNECT BY LEVEL <=50 -- level pseudocolumn can be used when Connect by keyword is used. Level help us to sequence.

Example3:

SELECT LEVEL+(5)
FROM dual CONNECT BY LEVEL <=50 -- Here we can start from 6 instead of 1.

/*NOCYCLE*/

WITH employees AS (
    SELECT 1 AS emp_id, 'Alice' AS name, 2 AS manager_id FROM dual
    UNION ALL
    SELECT 2, 'Bob', 3 FROM dual
    UNION ALL
    SELECT 3, 'Charlie', 1 FROM dual -- This creates a cycle
)
SELECT emp_id, name, manager_id, LEVEL
FROM employees
START WITH name = 'Alice'
CONNECT BY NOCYCLE PRIOR emp_id = manager_id;

--Above script avoid infinity loop because of NOCYCLE keyword, if we remove NOCYCLE keyword from above SQL, Oracle will through error.