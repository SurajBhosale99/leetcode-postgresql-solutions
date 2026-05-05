select distinct email from employees
group by email
having count(*)>1;

-------------------------------------------

SELECT DISTINCT e1.email
FROM employees e1
JOIN employees e2
ON e1.email = e2.email
AND e1.employee_id != e2.employee_id;



