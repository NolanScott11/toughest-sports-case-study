SELECT 
    category,
    COUNT(*) AS number_of_sports,
    ROUND(AVG(physicality_score), 2) AS avg_physicality,
    ROUND(AVG(finesse_score), 2) AS avg_finesse,
    ROUND(AVG(mental_score), 2) AS avg_mental,
    ROUND(AVG(total_athletic_index), 2) AS avg_overall_index
FROM `sports_data.skill_rankings`
GROUP BY category
ORDER BY avg_overall_index DESC;