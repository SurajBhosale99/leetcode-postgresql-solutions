/*

Problem:

Find all customers who never placed any order.

Approach:

- Use a LEFT JOIN to keep all customers from the Customers table.

- Match customers with orders using customer id.

- Customers who never ordered will have NULL values in the Orders table columns.

- Filter those rows using WHERE o.customerId IS NULL.

*/

SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o
ON c.id = o.customerId
WHERE o.customerId IS NULL;