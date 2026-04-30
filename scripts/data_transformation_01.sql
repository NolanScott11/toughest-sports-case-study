CREATE OR REPLACE TABLE `sports_data.skill_rankings` AS
SELECT SPORT AS sport,
Endurance AS endurance,
Strength AS strength,
Power AS power,
Speed AS speed,
Agility as Agility,
Flexibility AS flexibility,
Nerve AS nerve,
Durability AS durability,
`Hand-eye coordination` AS hand_eye_coordination,
`Analytical Aptitude` AS analytical_aptitude,
Total AS total_score,
Rank AS rank 
FROM `sports_data.skill_rankings`;