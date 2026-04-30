SELECT 
    sport, 
    total_athletic_index, 
    RANK() OVER (ORDER BY total_athletic_index DESC) AS custom_rank,
    rank AS original_rank
FROM `sports_data.skill_rankings`
WHERE category = 'Precision & Racket'
ORDER BY total_athletic_index DESC;