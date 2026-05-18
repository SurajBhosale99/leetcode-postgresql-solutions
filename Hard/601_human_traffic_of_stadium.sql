-- Approach:
-- Step 1: Filter stadium records where people >= 100
-- Step 2: Find consecutive triplets using self joins
-- Step 3: Combine all valid rows using UNION to avoid duplicates
-- Step 4: Order final result by visit_date

SELECT DISTINCT s1.*
FROM Stadium s1, Stadium s2, Stadium s3
WHERE s1.people >= 100
  AND s2.people >= 100
  AND s3.people >= 100
  AND (
        (s1.id = s2.id - 1 AND s2.id = s3.id - 1)
     OR (s2.id = s1.id - 1 AND s1.id = s3.id - 1)
     OR (s3.id = s2.id - 1 AND s2.id = s1.id - 1)
  )

UNION

SELECT DISTINCT s2.*
FROM Stadium s1, Stadium s2, Stadium s3
WHERE s1.people >= 100
  AND s2.people >= 100
  AND s3.people >= 100
  AND (
        (s1.id = s2.id - 1 AND s2.id = s3.id - 1)
     OR (s2.id = s1.id - 1 AND s1.id = s3.id - 1)
     OR (s3.id = s2.id - 1 AND s2.id = s1.id - 1)
  )

UNION

SELECT DISTINCT s3.*
FROM Stadium s1, Stadium s2, Stadium s3
WHERE s1.people >= 100
  AND s2.people >= 100
  AND s3.people >= 100
  AND (
        (s1.id = s2.id - 1 AND s2.id = s3.id - 1)
     OR (s2.id = s1.id - 1 AND s1.id = s3.id - 1)
     OR (s3.id = s2.id - 1 AND s2.id = s1.id - 1)
  )

ORDER BY visit_date;