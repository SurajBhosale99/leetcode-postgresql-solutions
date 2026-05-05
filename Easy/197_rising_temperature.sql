Problem:

Find all dates' ids where the temperature is higher than the previous day.

Approach:
- Use a self join because we need to compare rows from the same table.
- w1 represents today's weather data.
- w2 represents yesterday's weather data.
- Match rows where today's date is exactly 1 day after yesterday's date.
- Then check if today's temperature is greater than yesterday's temperature.

----------------------------------------------

SELECT w1.id
FROM Weather w1
JOIN Weather w2
ON w1.recordDate = w2.recordDate + INTERVAL '1 day'
WHERE w1.temperature > w2.temperature;