/*
Problem:
Find the first login date for each player.

Approach:
- Each player can have multiple login records on different dates.
- Use GROUP BY player_id to group all records of the same player.
- Use MIN(event_date) to get the earliest login date for each player.
- Rename the result as first_login.
*/

SELECT player_id,
       MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;