-- File: 3808_find_emotionally_consistent_users.sql

/*
Approach:
1. Count how many times each user used each reaction.
2. Count total reactions per user.
3. Keep only users with at least 5 different content items.
4. Use RANK() to find the most frequent reaction for each user.
5. Calculate reaction ratio:
      dominant_reaction_count / total_reactions
6. Keep users whose ratio is at least 0.60.
7. Sort by reaction_ratio DESC and user_id ASC.

Pattern Used:
Aggregate → Rank → Filter
*/

WITH reaction_counts AS (
    SELECT
        user_id,
        reaction,
        COUNT(*) AS reaction_count
    FROM reactions
    GROUP BY user_id, reaction
),

total_reactions AS (
    SELECT
        user_id,
        COUNT(*) AS total_count
    FROM reactions
    GROUP BY user_id
    HAVING COUNT(DISTINCT content_id) >= 5
),

ranked_reactions AS (
    SELECT
        rc.user_id,
        rc.reaction,
        rc.reaction_count,
        tr.total_count,

        ROUND(
            rc.reaction_count * 1.0 / tr.total_count,
            2
        ) AS reaction_ratio,

        RANK() OVER(
            PARTITION BY rc.user_id
            ORDER BY rc.reaction_count DESC
        ) AS rnk

    FROM reaction_counts rc
    JOIN total_reactions tr
        ON rc.user_id = tr.user_id
)

SELECT
    user_id,
    reaction AS dominant_reaction,
    reaction_ratio
FROM ranked_reactions
WHERE rnk = 1
  AND reaction_ratio >= 0.60
ORDER BY reaction_ratio DESC, user_id ASC;

