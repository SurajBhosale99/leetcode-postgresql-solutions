/*
Approach:
1. Group transactions by customer_id.
2. Count:
      - purchase transactions
      - refund transactions
      - total transactions
3. Find customer active period using:
      MAX(transaction_date) - MIN(transaction_date)
4. Refund rate formula:
      refund_count / total_transactions
5. Use HAVING to filter customers who:
      - have at least 3 purchases
      - are active for at least 30 days
      - refund rate is less than 20%
6. Return results ordered by customer_id.

Key Concepts:
- GROUP BY
- CASE WHEN
- Aggregate Functions
- HAVING
- Date Difference

Time Complexity:
- O(n)
*/

SELECT 
    customer_id
FROM customer_transactions
GROUP BY customer_id
HAVING 
    SUM(CASE 
            WHEN transaction_type = 'purchase' THEN 1 
            ELSE 0 
        END) >= 3
    AND 
    MAX(transaction_date) - MIN(transaction_date) >= 30
    AND
    (
        SUM(CASE 
                WHEN transaction_type = 'refund' THEN 1 
                ELSE 0 
            END) * 1.0
        / COUNT(*)
    ) < 0.2
ORDER BY customer_id;