-- Approach:
-- Select countries that satisfy at least one condition:
-- 1. Area >= 3,000,000
-- 2. Population >= 25,000,000
-- Use OR because either condition makes a country "big".

SELECT name, population, area
FROM World
WHERE area >= 3000000
   OR population >= 25000000;



   -- Approach:
-- Retrieve countries with:
-- 1. Area greater than or equal to 3,000,000
-- 2. Population greater than or equal to 25,000,000
--
-- UNION combines both result sets and removes duplicates automatically,
-- so countries satisfying both conditions appear only once.

SELECT name, population, area
FROM World
WHERE area >= 3000000

UNION

SELECT name, population, area
FROM World
WHERE population >= 25000000;