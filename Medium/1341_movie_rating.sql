
--  PROBLEM BREAKDOWN:

-- We need to return 2 rows:
-- 1) User who rated the MOST movies
--    - tie → pick lexicographically smaller name

-- 2) Movie with HIGHEST average rating in Feb 2020
--    - tie → pick lexicographically smaller title

-- Step 1:
-- Count number of ratings per user_id

-- Step 2:
-- Join with Users table to get name

-- Step 3:
-- Order by:
--   1. highest count DESC
--   2. name ASC (tie-breaker)
-- Pick top 1


WITH user_rank AS (
    SELECT 
        u.name,
        COUNT(*) AS rating_count
    FROM MovieRating mr
    JOIN Users u
        ON mr.user_id = u.user_id
    GROUP BY u.name
),
top_user AS (
    SELECT name
    FROM user_rank
    ORDER BY rating_count DESC, name ASC
    LIMIT 1
)
-- PART 2: MOVIE WITH HIGHEST AVG RATING IN FEB 2020


, movie_rank AS (
    SELECT 
        m.title,
        AVG(mr.rating) AS avg_rating
    FROM MovieRating mr
    JOIN Movies m
        ON mr.movie_id = m.movie_id
    WHERE mr.created_at >= '2020-02-01'
      AND mr.created_at <  '2020-03-01'
    GROUP BY m.title
),
top_movie AS (
    SELECT title
    FROM movie_rank
    ORDER BY avg_rating DESC, title ASC
    LIMIT 1
)


SELECT name AS results FROM top_user
UNION ALL
SELECT title FROM top_movie;