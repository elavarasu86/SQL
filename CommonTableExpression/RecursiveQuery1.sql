Finding factorial:

with factorialTop10 (num,resultFact) as
(
select 1,1 from dual
union all
select num+1,(num+1)*resultFact
from factorialTop10
where num < 10
)
select * from factorialTop10;

Finding Odd and Even NUMBER

With odd_even(sr_no, oddNo,evenNo)
as
(
select 1,1,2 from dual
union all
select sr_no+1,oddNo+2, evenNo+2
from odd_even
where sr_no <=9
) 
select * from ood_even;

Employee Manager Hierarchy

with mgr_emp (emp_id,name,mgr_id) as(
select emp_id,name,mgr_id from department where mgr_id is NULL
union all
select department.emp_id,department.name,department.mgr_id from mgr_emp,department where mgr_emp.emp_id=department.mgr_id and department.mgr_id is not null
)
select * from mgr_emp;
