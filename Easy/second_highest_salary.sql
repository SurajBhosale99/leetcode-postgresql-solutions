select 
    distinct salary
from employees
order by salary desc
limit 1 offset 1

-----------------------------------

Select max(salary) as second_higheest_salary
from employees
where salary < (select max(salary) from employees) 


------------------------------------------
select salary 
from(select salary,
DENSE_RANK() OVER(ORDER BY salary desc) as rnk
from employees
)t
where rnk=2;