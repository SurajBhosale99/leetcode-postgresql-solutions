/*
Problem:
Find employees who:
1. Have a bonus less than 1000
OR
2. Did not receive any bonus

Approach:
- Use LEFT JOIN to include all employees even if they don't have a bonus.
- Employees without bonus will have NULL values in the Bonus table.
- Filter rows where:
    bonus < 1000
    OR bonus IS NULL
*/

SELECT e.name, b.bonus
FROM Employee e
LEFT JOIN Bonus b
ON e.empId = b.empId
WHERE b.bonus < 1000
OR b.bonus IS NULL;