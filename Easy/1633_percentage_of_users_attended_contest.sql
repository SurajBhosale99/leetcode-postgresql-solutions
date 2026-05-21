/*
Approach:
1. Get total number of users from Users table
2. Count distinct users per contest from Register table
3. Compute percentage = (contest_users / total_users) * 100
4. Round to 2 decimal places
5. Sort by percentage DESC, contest_id ASC
------------------------------------------------------------
*/

WITH total_users AS (
    SELECT COUNT(*) AS total FROM Users
),
contest_counts AS (
    SELECT 
        contest_id,
        COUNT(DISTINCT user_id) AS user_count
    FROM Register
    GROUP BY contest_id
)

SELECT 
    c.contest_id,
    ROUND((c.user_count * 100.0) / t.total, 2) AS percentage
FROM contest_counts c
CROSS JOIN total_users t
ORDER BY 
    percentage DESC,
    contest_id ASC;