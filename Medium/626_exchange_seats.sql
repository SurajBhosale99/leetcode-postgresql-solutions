-- LeetCode 626. Exchange Seats
-- Difficulty: Medium

/*
Approach:
---------
We need to swap every two consecutive seat IDs.

Examples:
1 <-> 2
3 <-> 4
5 stays same (if total students are odd)

Logic:
------
1. If the ID is odd:
      - normally swap with next ID -> id + 1
      - but if it is the last row, keep it unchanged

2. If the ID is even:
      - swap with previous ID -> id - 1

3. Use CASE statement to generate the new swapped IDs.

4. Order the final output by the new ID.

Time Complexity:
----------------
O(n)

SQL Solution:
------------- */

SELECT
    CASE
        -- If last student and odd count, keep same id
        WHEN id % 2 = 1
             AND id = (SELECT MAX(id) FROM Seat)
        THEN id

        -- Odd ids move forward
        WHEN id % 2 = 1
        THEN id + 1

        -- Even ids move backward
        ELSE id - 1
    END AS id,
    student
FROM Seat
ORDER BY id;