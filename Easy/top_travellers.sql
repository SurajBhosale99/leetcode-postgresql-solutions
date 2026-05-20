
/*
Approach:
1. We need total travelled distance for every user.
2. Use LEFT JOIN so that users with no rides are also included.
3. Use SUM(distance) to calculate total distance travelled.
4. SUM() returns NULL for users with no rides, so use COALESCE(..., 0).
5. GROUP BY user details to aggregate distances correctly.
6. Sort by:
      - travelled_distance DESC
      - name ASC (for tie-breaking)

Time Complexity:
- O(n log n) due to sorting

Concepts Used:
- LEFT JOIN
- GROUP BY
- SUM()
- COALESCE()
- ORDER BY
*/

SELECT 
    u.name,
    COALESCE(SUM(r.distance), 0) AS travelled_distance
FROM Users u
LEFT JOIN Rides r
ON u.id = r.user_id
GROUP BY u.id, u.name
ORDER BY travelled_distance DESC, u.name ASC;