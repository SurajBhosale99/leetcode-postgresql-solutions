-- Problem: 570. Managers with at Least 5 Direct Reports
-- Platform: LeetCode
-- Difficulty: Medium

/*
APPROACH:

1. Each employee has a managerId pointing to their manager.
2. We group employees by managerId.
3. Count how many direct reports each manager has.
4. Filter only those managers who have 5 or more direct reports.
5. Return the manager's name from the same table using self join.
*/

SELECT m.name
FROM Employee e
JOIN Employee m
    ON e.managerId = m.id
GROUP BY m.id, m.name
HAVING COUNT(e.id) >= 5;