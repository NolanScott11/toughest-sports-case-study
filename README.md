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

![changing column names]('images/data_transformation_01')

### Feature Engineering
New variables were created to improve comparability:

- Average Physicality Score  
- Average Mental Score  
- Average Finesse Score  
- Adjusted Rank (based on equal weighting of all categories)  
- Dominance Gap (difference between strongest and weakest category)  
- Dominant Category (most influential skill dimension per sport)

---

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

![Slope Chart](images/slope_chart.png)

**Key Insight:**  
Reweighting reveals significant ranking changes, suggesting traditional systems favor physical intensity over skill-based evaluation.

---

### 2. Top Sports by Category

Bar charts showing top-performing sports in:
- Physicality
- Mental skill
- Finesse

![Category Charts](images/category_bars.png)

---

### 3. Skill vs Physicality Relationship

Scatter plot showing how sports cluster based on physical vs mental demand.

![Scatter Plot](images/scatter.png)

---

### 4. Dominance Gap (Specialization Analysis)

Shows how unbalanced each sport is across categories.

![Dominance Chart](images/dominance.png)

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

## 📊 Dashboard

🔗 Interactive Tableau Dashboard:  
[Insert Tableau Public Link Here]

---

## 🚀 Future Improvements

- Add player-level or league-level data for deeper analysis
- Introduce time-based ranking changes
- Build predictive model for sport difficulty scoring
- Expand dataset to include more niche sports
