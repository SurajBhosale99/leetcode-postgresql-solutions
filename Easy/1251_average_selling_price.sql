/*

Approach:
1. Join UnitsSold with Prices using product_id + date range
2. Compute revenue = units * price
3. Aggregate revenue and units per product
4. average_price = SUM(revenue) / SUM(units)
5. Handle no sales using COALESCE and NULLIF
6. Round result to 2 decimal places
------------------------------------------------------------
*/

WITH joined_data AS (
    SELECT 
        u.product_id,
        u.units,
        p.price
    FROM UnitsSold u
    LEFT JOIN Prices p
        ON u.product_id = p.product_id
       AND u.purchase_date BETWEEN p.start_date AND p.end_date
)

SELECT 
    product_id,
    ROUND(
        COALESCE(
            SUM(units * price) * 1.0 / NULLIF(SUM(units), 0),
            0
        ),
        2
    ) AS average_price
FROM joined_data
GROUP BY product_id;