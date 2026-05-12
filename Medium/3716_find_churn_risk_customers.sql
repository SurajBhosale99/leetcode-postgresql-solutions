/*
Approach:
1. Find each user's latest subscription event.
2. Keep only active users (last event is not 'cancel').
3. Find users who have at least one downgrade event.
4. Calculate:
      - current subscription amount
      - historical maximum subscription amount
      - days as subscriber
5. Keep users where:
      current_amount < 50% of max_historical_amount
6. Keep users subscribed for at least 60 days.
7. Sort by:
      days_as_subscriber DESC,
      user_id ASC

Pattern Used:
Aggregate → Window Function → Filter
*/

WITH ranked_events AS (
    SELECT
        *,
        ROW_NUMBER() OVER(
            PARTITION BY user_id
            ORDER BY event_date DESC, event_id DESC
        ) AS rn
    FROM subscription_events
),

current_status AS (
    SELECT
        user_id,
        plan_name AS current_plan,
        monthly_amount AS current_monthly_amount,
        event_type
    FROM ranked_events
    WHERE rn = 1
),

user_history AS (
    SELECT
        user_id,

        MAX(monthly_amount) AS max_historical_amount,

        MIN(event_date) AS first_event_date,

        MAX(event_date) AS last_event_date,

        MAX(
            CASE
                WHEN event_type = 'downgrade' THEN 1
                ELSE 0
            END
        ) AS has_downgrade

    FROM subscription_events
    GROUP BY user_id
),

final_result AS (
    SELECT
        cs.user_id,
        cs.current_plan,
        cs.current_monthly_amount,
        uh.max_historical_amount,

        DATEDIFF(
            uh.last_event_date,
            uh.first_event_date
        ) AS days_as_subscriber

    FROM current_status cs
    JOIN user_history uh
        ON cs.user_id = uh.user_id

    WHERE cs.event_type != 'cancel'
      AND uh.has_downgrade = 1
      AND cs.current_monthly_amount < (
            uh.max_historical_amount * 0.5
      )
      AND DATEDIFF(
            uh.last_event_date,
            uh.first_event_date
      ) >= 60
)

SELECT *
FROM final_result
ORDER BY days_as_subscriber DESC, user_id ASC;

/*
Time Complexity:
O(N log N)

Concepts Used:
- CTE
- ROW_NUMBER()
- CASE WHEN
- Aggregate Functions
- Window Functions
- Filtering
- Date Functions

