-- 184. Department Highest Salary
-- LeetCode (Medium)

-- APPROACH:
-- 1. Find maximum salary in each department
-- 2. Match employees who have that salary
-- 3. Join Department table to get department name

SELECT 
    d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary
FROM Employee e
JOIN Department d
    ON e.departmentId = d.id
WHERE (e.departmentId, e.salary) IN (
    SELECT departmentId, MAX(salary)
    FROM Employee
    GROUP BY departmentId
);