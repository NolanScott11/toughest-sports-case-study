UPDATE `sports_data.skill_rankings` 
SET category = CASE 
    -- Using TRIM and LOWER makes the search case-insensitive and ignores accidental spaces
    WHEN LOWER(TRIM(sport)) IN ('boxing', 'wrestling', 'martial arts', 'fencing', 'football', 'rugby') THEN 'Combat & Contact'
    
    WHEN LOWER(TRIM(sport)) IN ('basketball', 'ice hockey', 'soccer', 'baseball/softball', 'volleyball', 'water polo', 'lacrosse', 'field hockey', 'team handball') THEN 'Team Ball'
    
    WHEN LOWER(TRIM(sport)) IN ('tennis', 'racquetball/squash', 'badminton', 'table tennis', 'golf', 'bowling', 'billiards', 'curling', 'archery', 'shooting') THEN 'Precision & Racket'
    
    WHEN LOWER(TRIM(sport)) LIKE 'track and field%' THEN 'Track & Field'
    
    WHEN LOWER(TRIM(sport)) IN ('swimming (all strokes): sprints', 'swimming (all strokes): distance', 'diving', 'water skiing', 'canoe/kayak', 'surfing', 'rowing') THEN 'Water Sports'
    
    WHEN LOWER(TRIM(sport)) IN ('speed skating', 'figure skating', 'ski jumping', 'skiing: nordic', 'skiing: freestyle', 'skiing: alpine', 'bobsledding/luge', 'roller skating') THEN 'Winter & Skating'
    
    WHEN LOWER(TRIM(sport)) IN ('cycling: sprints', 'cycling: distance', 'auto racing', 'horse racing', 'skateboarding') THEN 'Racing & Extreme'
    
    WHEN LOWER(TRIM(sport)) IN ('gymnastics', 'cheerleading', 'weight-lifting') THEN 'Technical & Strength'
    
    WHEN LOWER(TRIM(sport)) LIKE 'rodeo%' OR LOWER(TRIM(sport)) IN ('equestrian', 'fishing') THEN 'Rodeo & Outdoor'
    
    ELSE 'Other' 
END
WHERE 1=1;