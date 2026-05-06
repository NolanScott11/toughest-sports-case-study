# toughest-sports-case-study
# 🏆 Ranking Sports by Physicality, Finesse, and Mental

This project explores the long-debated question:  
**Which sports are the most difficult, and how should “difficulty” be defined?**

A previous data study by espn ranked 60 sports in level of difficulty but their metrics favored physical sports by having significantly more, semi-redundant, physical metrics with few other metrics related to things such as hand-eye coordination.

The goal is to determine how rankings change when different dimensions of performance are weighted differently, equaling out physical, mental, and skill/finesse attributes. The secondary goal is to enrich the data and pull more out of it to see which sports reign which categories and to investigate certain outliers.

---

## Dataset

Source: Kaggle – Ranking Sports by Skill Requirement  
https://www.kaggle.com/datasets/jainaru/ranking-sports-by-skill-requirement

The dataset includes multiple sports evaluated across:
- Physical attributes
- Mental attributes
- Skill/finesse attributes

---

## Data Preparation & Cleaning

Data cleaning and transformation were performed using SQL in Google BigQuery.

Key steps included:
- Checking for NULL values
- Making column names uniform

```sql
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
```

### Feature Engineering
New columns were created to improve comparability:

- Average Physicality Score  
- Average Mental Score  
- Average Finesse Score
- Category (what type of sport a sport is)
- Adjusted score (based on equal weighting of all categories)

```sql
ALTER TABLE `sports_data.skill_rankings`
ADD COLUMN category STRING;

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
```

```sql
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
```

### Data Analysis

With these new columns, I was able to find things such as:

- Original Rankings vs. Adjusted Rankings
```sql
SELECT 
    sport, 
    total_athletic_index, 
    RANK() OVER (ORDER BY total_athletic_index DESC) AS custom_rank,
    rank AS original_rank
FROM `sports_data.skill_rankings`
ORDER BY total_athletic_index DESC;
```

- Dominance Gap (difference between strongest and weakest category to show which sport relied most on 1 metric.)
```sql
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
```

- Dominant Category (most influential skill dimension per sport)


## ⚙️ Methodology

The analysis compares sports across multiple perspectives:

1. **Original Ranking vs Adjusted Ranking**
   - Original ranking is more physically biased
   - Adjusted ranking equally weights all categories

2. **Ranking Change Analysis**
   - Identifies sports that move significantly when weighting changes

3. **Category Dominance**
   - Determines whether a sport is primarily physical, mental, or finesse-based

4. **Outlier & Specialization Detection**
   - Measures how balanced or specialized each sport is

---

## 📈 Visualizations

### 1. Ranking Shift (Slope Chart)

Shows how sports move between original and adjusted rankings.

![Slope Chart](images/Tableau%20original%20vs%20adjusted.png)

**Key Insight:**  
Reweighting reveals significant ranking changes, suggesting traditional systems favor physical intensity over skill-based evaluation.

---

### 2. Top Sports by Category

Bar charts showing top-performing sports in:
- Physicality
- Mental skill
- Finesse

![Slope Chart](images/Tableau%20top%20at%20each%20score%20type.png)

---





---

### 4. Dominance Gap (Specialization Analysis)

Shows how unbalanced each sport is across categories.

![Slope Chart](images/Tableau%20greatest%20diff.png)
![Slope Chart](images/Tableau%20smallest%20diff.png)

**Key Insight:**  
Some sports are highly specialized toward one dominant skill type, while others are more balanced across all dimensions.

---

## 🧠 Key Findings

- Sports rankings change significantly when skill is weighted equally with physical ability
- Many traditionally high-ranked sports are physically dominant but not necessarily skill-balanced
- Certain sports rely heavily on a single dominant category
- True “difficulty” is multidimensional and cannot be captured by physicality alone

---

## 📌 Tools Used

- Google BigQuery (SQL for data cleaning & transformation)
- Tableau Public Desktop (data visualization)
- Excel / CSV preprocessing
- GitHub (project documentation)

---

## 🚀 Future Improvements

- Add player-level or league-level data for deeper analysis
- Introduce time-based ranking changes
- Build predictive model for sport difficulty scoring
- Expand dataset to include more niche sports
