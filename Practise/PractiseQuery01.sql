Write a query to select the rows that have "A" in any one of the columns(col1,col2,col3) without using "OR" Keyword.

Table:
S.no	col1	col2	col3
1		A		B		C
2				A		B
3		E				
4				A		E
5		E		D		C

Solution1:
select * from table_name where col1='A' OR col2='A' OR col3='A';

Solution2:
select * from table_name where col1='A' union all
select * from table_name where col2='A' union all
select * from table_name where col3='A';

Solution3:
select * from table_name where 'A' in (col1,col2,col3);

Solution4:
Select * from table_name where col1||col2||col3 like '%A%'; /* Here we are concatenating column value and using like operatior.*/

Solution5:
Select * from table_name where instr(col1||col2||col3,'A')>0;
