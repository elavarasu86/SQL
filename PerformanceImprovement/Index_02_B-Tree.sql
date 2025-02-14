Where to use B-Tree(Balanced Tree) Index:
 When a field has high cardinality(Unique/Less duplicate) then use B-Tree Index.

Example
  1. Employee Number in Employee table.
  2. Plcy_nbr in plcy_trnsctn table.(plcy number is not unique but has less duplicate)

Type of Scan:

Range Scan:
  Indexed field is not unique here so for the given value there might be duplicate records in the table.
  For Example: When we search plcy_trnsctn table with policy number.

Unique Scan:
  Indexed field is unique here so for the given value there is no duplicate record in the table.
  For Example: When we search plcy_trnsctn table with Job Number.

Index Full Scan:(Index is Sorted by default)
  When Oracle scan's complete index.
  For Example: We have Index on Salary field of employee table, when we issue below query Oracle sacn complete index.
  Select Sum(Sal) from emp;

Index Full Scan(Min/Max):(Index is Sorted by default)
  This type of scan also similar to Index Full Scan, only difference here is in the given Index Oracle will pick Min/Max based on given query.
  For Example: We have Index on Salary field of employee table, when we issue below query Oracle sacn complete index.
  select Max(sal) from emp;

Fast Full Scan:
  When fields mentioned in the select clause is indexed, then Oracle pick data from indexes and combines into one. 
  For Example: When using plcy_nbr, job_nbr in select clause, Oracle uses Fast Full Scan.
  Select plcy_nbr, job_nbr from plcy_trnsctn;
