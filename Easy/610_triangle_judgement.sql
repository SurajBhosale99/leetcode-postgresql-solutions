/*
Approach:
A triangle is valid only if the sum of any two sides
is greater than the third side.

Triangle Conditions:
1. x + y > z
2. x + z > y
3. y + z > x

If all conditions are true -> 'Yes'
Otherwise -> 'No'

We use CASE statement to check the conditions.
*/

SELECT
    x,
    y,
    z,

    CASE
        WHEN x + y > z
         AND x + z > y
         AND y + z > x
        THEN 'Yes'

        ELSE 'No'
    END AS triangle

FROM Triangle;