/*
Approach:
1. Group all numbers using GROUP BY num
2. Use HAVING COUNT(*) = 1 to keep only numbers that appear once
3. Use MAX(num) to find the largest single number
4. If no single number exists, MAX() returns NULL automatically

Time Complexity:
- O(n)

Space Complexity:
- O(n) for grouping
*/

SELECT MAX(num) AS num
FROM (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(*) = 1
) AS single_numbers;