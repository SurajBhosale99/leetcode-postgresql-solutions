-- Problem: Count number of unique subjects taught by each teacher

SELECT 
    teacher_id, 
    -- COUNT(DISTINCT subject_id) ensures we only count each subject once per teacher
    COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
-- Group rows by teacher so we calculate result per teacher
GROUP BY teacher_id;