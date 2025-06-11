SYNTAX:

SELECT * FROM
(
  SELECT column1, column2
  FROM tables
  WHERE conditions
)
PIVOT 
(
  aggregate_function(column2)
  FOR column2
  IN ( expr1, expr2, ... expr_n) | subquery
)
ORDER BY expression [ ASC | DESC ];

/*
aggregate_function
It can be a function such as SUM, COUNT, MIN, MAX, or AVG functions.
IN ( expr1, expr2, ... expr_n )
A list of values for column2 to pivot into headings in the cross-tabulation query results.
subquery
It can be used instead of a list of values. In this case, the results of the subquery would be used to determine the values for column2 to pivot into headings in the cross-tabulation query results.
*/

Sample: 
order_id	customer_ref	product_id
50001	SMITH	10
50002	SMITH	20
50003	ANDERSON	30
50004	ANDERSON	40
50005	JONES	10
50006	JONES	20
50007	SMITH	20
50008	SMITH	10
50009	SMITH	20


SELECT * FROM
(
  SELECT customer_ref, product_id
  FROM orders
)
PIVOT
(
  COUNT(product_id)
  FOR product_id IN (10, 20, 30)
)
ORDER BY customer_ref;


Output:
customer_ref	10	20	30
ANDERSON	0	0	1
JONES	1	1	0
SMITH	2	3	0

Example2:

select * from (select pv.rlt_entity_id as a pc.ptrn_rfrnc_cd as b from plcy_prsnl_vhcl pv, plcy_cvrg pc
where pv.prsnl_vhcl_id=pc.rlt_entity_id )
pivot(
count(b)
for b in ('BI','PD','RENTRE','COLL','COMP','OEM','GAPCOLL'))
order by a;