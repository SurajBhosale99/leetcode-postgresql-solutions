-- Approach:
-- Group orders by customer_number.
-- Count how many orders each customer placed.
-- Sort by order count in descending order.
-- Return the top customer using LIMIT 1.

SELECT customer_number
FROM Orders
GROUP BY customer_number
ORDER BY COUNT(*) DESC
LIMIT 1;