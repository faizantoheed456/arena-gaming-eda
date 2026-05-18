# 🎮 ARENA – Gaming Communities EDA

**Exploratory Data Analysis of 400+ gaming communities worldwide.**  
This project analyzes gaming communities across genres, tiers, regions, and platforms. The goal is to uncover patterns in community growth, engagement, tournaments, and demographics. The analysis is divided into four sessions: loading & inspection, data cleaning, grouping/aggregation/feature engineering, and visualisation/statistics.

---

## 📁 Dataset

- **Raw file:** `gaming_communities.csv` (400 rows, 28 columns)
- **Cleaned file:** `gaming_communities_data_cleaned.csv` (357 rows, 21 columns, 0 missing values)
- **Enhanced file:** `gaming_communities_enhanced.csv` (357 rows, 31+ columns with new features)

---

## 📂 Repository Structure

```text
arena-gaming-eda/
├── gaming_communities.csv                          # raw dataset
├── gaming_communities_data_cleaned.csv             # cleaned dataset (Session 2)
├── gaming_communities_enhanced.csv                 # enhanced dataset (Session 3)
├── ARENA_session_1_load_inspect.ipynb              # Session 1 notebook
├── ARENA_session_2_clean.ipynb                     # Session 2 notebook
├── ARENA_session_3_groupby_feature_eng.ipynb       # Session 3 notebook
├── README.md                                       # this file
└── (Session 4 notebooks will be added)

## 🛠️ Installation & Setup

```bash
# 1. Clone the repository
git clone https://github.com/yourusername/arena-gaming-eda.git
cd arena-gaming-eda

# 2. (Optional) Create a virtual environment
python -m venv venv
source venv/bin/activate        # Linux/Mac
venv\Scripts\activate           # Windows

# 3. Install required libraries
pip install pandas numpy matplotlib seaborn plotly scipy

# 4. Launch Jupyter Notebook
jupyter notebook

## 📊 Sessions Overview

| Session | Focus | Notebook | Status |
|---------|-------|----------|--------|
| 1 | Data loading, inspection, missing value detection | `ARENA_session_1_load_inspect.ipynb` | ✅ Complete |
| 2 | Data cleaning, imputation, outlier capping, type conversion | `ARENA_session_2_clean.ipynb` | ✅ Complete |
| 3 | Grouping, aggregations, feature engineering, pivot tables | `ARENA_session_3_groupby_feature_eng.ipynb` | ✅ Complete |
| 4 | Visualisation (Matplotlib, Seaborn, Plotly) and statistics | *to be added* | ⏳ Planned |

## 🔍 Key Insights from Session 3

- **Engagement:** Battle Royale and MMORPG have the highest active‑player ratios (~45%).  
- **Tier distribution:** Asia has the highest average tier score (1.63); South America the lowest (1.37).  
- **Coaching:** 100% of Elite & Professional communities have coaching; 0% of Amateur do.  
- **Tournaments:** Semi‑Pro communities host the most tournaments (525 total).  
- **Language:** English dominates (141 communities), followed by Spanish (62) and Portuguese (32).  
- **Social presence:** `Pulse Nation` has the highest total social presence (Discord + Reddit + content creators).  
- **Oldest communities:** In EU, a community was founded in 2008 (18 years old).  
- **Regional inequality:** Only 18.8% of communities have member counts above their region’s average.

## 🧪 How to Reproduce the Analysis

1. Open `ARENA_session_1_load_inspect.ipynb` and run all cells to inspect raw data.  
2. Open `ARENA_session_2_clean.ipynb` and run all cells to clean and save `gaming_communities_data_cleaned.csv`.  
3. Open `ARENA_session_3_groupby_feature_eng.ipynb` and run all cells to generate the enhanced dataset.  
4. Use `gaming_communities_enhanced.csv` for your own visualisation or statistical tests.

## 📄 License

This project is for educational purposes. The dataset is synthetic/inspired by real‑world gaming communities.

## 👥 Project Team

- **Faizan Toheed** – Lead Analyst (sole contributor)