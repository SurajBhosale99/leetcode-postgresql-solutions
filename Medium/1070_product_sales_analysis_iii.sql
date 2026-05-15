--  APPROACH:
-- 1. For each product_id, find the earliest year it was sold
--    -> use MIN(year) with GROUP BY
--
-- 2. Join this result back to Sales table
--    -> match both product_id and year = first_year
--
-- 3. Return all sales rows from that first year
-- =====================================================

WITH first_year_cte AS (
    SELECT 
        product_id,
        MIN(year) AS first_year   -- step 1: find earliest year per product
    FROM Sales
    GROUP BY product_id
)

SELECT 
    s.product_id,
    f.first_year,
    s.quantity,
    s.price
FROM Sales s
JOIN first_year_cte f
    ON s.product_id = f.product_id   -- match product
   AND s.year = f.first_year;        -- keep only first-year sales