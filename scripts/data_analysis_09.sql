SELECT 
    sport,
    category,
    physicality_score,
    finesse_score,
    mental_score,
    ROUND(GREATEST(physicality_score, finesse_score, mental_score) - 
          LEAST(physicality_score, finesse_score, mental_score), 2) AS skill_gap,
    CASE 
        WHEN (GREATEST(physicality_score, finesse_score, mental_score) - 
              LEAST(physicality_score, finesse_score, mental_score)) < 1.5 THEN 'Generalist'
        WHEN (GREATEST(physicality_score, finesse_score, mental_score) - 
              LEAST(physicality_score, finesse_score, mental_score)) > 3.0 THEN 'Specialist'
        ELSE 'Balanced'
    END AS athlete_type
FROM `sports_data.skill_rankings`
ORDER BY skill_gap ASC;