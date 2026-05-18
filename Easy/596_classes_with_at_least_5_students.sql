-- Approach:
-- We need to find classes that have at least 5 students.
-- Each row represents a student enrolled in a class.
-- Step 1: Group all rows by class using GROUP BY.
-- Step 2: Count number of students in each class using COUNT(student).
-- Step 3: Filter only those groups having 5 or more students using HAVING.
-- Note: HAVING is used instead of WHERE because we are filtering aggregated data.

-- Solution:
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;