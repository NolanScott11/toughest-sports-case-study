ALTER TABLE `sports_data.skill_rankings` 
ADD COLUMN total_athletic_index FLOAT64;

UPDATE `sports_data.skill_rankings`
SET total_athletic_index = ROUND(
    (physicality_score + finesse_score + mental_score) / 3, 
    2)
WHERE 1=1;