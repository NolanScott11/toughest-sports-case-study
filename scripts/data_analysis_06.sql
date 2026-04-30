SELECT 
    sport, 
    physicality_score,  
FROM `sports_data.skill_rankings`
ORDER BY physicality_score DESC;