-- Approach:
-- We need to find customers who were NOT referred by customer id = 2.
-- Some customers have NULL referee_id, meaning they were not referred by anyone.
-- Since NULL comparisons do not return TRUE in SQL,
-- we explicitly include rows where referee_id IS NULL.

SELECT name
FROM customer
WHERE referee_id != 2
   OR referee_id IS NULL;