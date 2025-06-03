/* SubQuery:
	1. Correlated SubQuery
		SubQuery cannot be considered as an independant query, but it can refer to the column in a table listed in the From of the main query.
	2. Non-Correlated SubQuery
		Can be considered as an independant query and the output of the subquery is substituted in the main query.*/


	
Correlated SubQuery Example:

SELECT *
FROM   plcy_trnsctn PT
WHERE  PT.plcy_trnsctn_id IN(SELECT plcy_trnsctn_id
                             FROM   plcy_brnch PB
                             WHERE  PT.plcy_nbr = PB.plcy_nbr
                                    AND PB.plcy_brnch = '') 
									
/* in the above query we are using plcy_nbr from plcy_trnsctn table in subquery which makes this query Correlated SubQuery*/

Non-Correlated SubQuery:

SELECT *
FROM   plcy_brnch pb
WHERE  plcy_trnsctn_id IN (SELECT plcy_trnsctn_id
                           FROM   plcy_trnsctn pt
                           WHERE  pt.job_nbr = '') 
						   
/*Above SubQuery does not depend on outer query which makes it non-SubQuery*/
