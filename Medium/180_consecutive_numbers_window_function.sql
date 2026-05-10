-- LeetCode 180. Consecutive Numbers
-- Alternative Solution Using Window Functions
-- Difficulty: Medium

/*
Approach:
---------
Use the LAG() window function to compare
the current row with previous rows.

Logic:
------
1. LAG(num, 1):
      gets previous row number

2. LAG(num, 2):
      gets number from two rows before

3. If:
      current num = previous num
      AND
      current num = num two rows before

   then the number appeared
   3 consecutive times.

4. Use DISTINCT to avoid duplicates.

Example:
--------
Rows:
id | num
-----------
1  | 1
2  | 1
3  | 1

For row 3:
current num = 1
previous num = 1
two rows before = 1

So 1 is returned.

Time Complexity:
----------------
O(n)

SQL Solution:
------------- */

SELECT DISTINCT
    num AS ConsecutiveNums
FROM (
    SELECT
        num,
        LAG(num, 1) OVER (ORDER BY id) AS prev_num,
        LAG(num, 2) OVER (ORDER BY id) AS prev_prev_num
    FROM Logs
) t
WHERE num = prev_num
  AND num = prev_prev_num;