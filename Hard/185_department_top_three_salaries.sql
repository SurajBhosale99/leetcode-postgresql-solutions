-- Problem: Find employees who are in top 3 unique salaries per department

SELECT 
    d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary
FROM (
    SELECT 
        *,
        -- Rank salaries within each department (highest salary = rank 1)
        DENSE_RANK() OVER (
            PARTITION BY departmentId 
            ORDER BY salary DESC
        ) AS rnk
    FROM Employee
) e
-- Join with Department table to get department name
JOIN Department d
    ON e.departmentId = d.id
-- Keep only top 3 unique salaries per department
WHERE e.rnk <= 3;