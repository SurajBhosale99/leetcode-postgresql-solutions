-- Approach:
-- 1. Find tiv_2015 values that appear more than once.
-- 2. Find locations (lat, lon) that are unique.
-- 3. Select rows satisfying both conditions.
-- 4. Sum tiv_2016 and round to 2 decimal places.


SELECT 
    ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN (
    
    -- Duplicate tiv_2015 values
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1
)

AND (lat, lon) IN (
    
    -- Unique locations
    SELECT lat, lon
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1
);