-- =====================================================
-- LeetCode 1321 - Restaurant Growth
-- =====================================================

/*
Approach:
1. First calculate total revenue per day because
   multiple customers can visit on the same date.

2. Use window functions to calculate:
   - 7-day rolling revenue
   - 7-day moving average

3. Use:
   ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
   to create a 7-day sliding window.

4. Remove first 6 rows because they do not
   have a complete 7-day window.
*/

WITH daily_sales AS (

    -- Step 1: Calculate daily revenue

    SELECT
        visited_on,
        SUM(amount) AS daily_amount
    FROM Customer
    GROUP BY visited_on
),

rolling_sales AS (

    -- Step 2: Calculate rolling 7-day metrics

    SELECT
        visited_on,

        -- 7-day rolling revenue
        SUM(daily_amount) OVER(
            ORDER BY visited_on
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS amount,

        -- 7-day moving average
        ROUND(
            AVG(daily_amount) OVER(
                ORDER BY visited_on
                ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
            ),
            2
        ) AS average_amount,

        -- Used to filter incomplete windows
        ROW_NUMBER() OVER(
            ORDER BY visited_on
        ) AS rn

    FROM daily_sales
)

-- Step 3: Return final result

SELECT
    visited_on,
    amount,
    average_amount
FROM rolling_sales
WHERE rn >= 7
ORDER BY visited_on;