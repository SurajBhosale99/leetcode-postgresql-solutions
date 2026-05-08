-- Approach:
-- 1. Create a CTE to calculate:
--      - total prompts submitted by each user
--      - average tokens used by each user
-- 2. Keep only users with at least 3 prompts using HAVING COUNT(*) >= 3.
-- 3. Join the CTE with the original prompts table.
-- 4. Check if the user has at least one prompt where
--    tokens > user's average token usage.
-- 5. Use GROUP BY to avoid duplicate rows.
-- 6. Sort results by avg_tokens DESC and user_id ASC.

WITH user_stats AS (
    SELECT
        user_id,
        COUNT(*) AS prompt_count,
        ROUND(AVG(tokens), 2) AS avg_tokens
    FROM prompts
    GROUP BY user_id
    HAVING COUNT(*) >= 3
)

SELECT
    u.user_id,
    u.prompt_count,
    u.avg_tokens
FROM user_stats u
JOIN prompts p
ON u.user_id = p.user_id
WHERE p.tokens > u.avg_tokens
GROUP BY u.user_id, u.prompt_count, u.avg_tokens
ORDER BY u.avg_tokens DESC, u.user_id ASC;