ALTER TABLE `sports_data.skill_rankings` 
ADD COLUMN physicality_score FLOAT64,
ADD COLUMN finesse_score FLOAT64,
ADD COLUMN mental_score FLOAT64;

UPDATE `sports_data.skill_rankings`
SET 
    physicality_score = ROUND((strength + power + durability + speed + endurance + flexibility) / 6, 2),
    
    finesse_score = ROUND((agility + hand_eye_coordination) / 2, 2),
    
    mental_toughness_index = ROUND((nerve + analytical_aptitude) / 2, 2)
WHERE 1=1;