# 🎮 ARENA – Gaming Communities EDA

**Exploratory Data Analysis of 400+ gaming communities worldwide.**  
This project analyzes gaming communities across genres, tiers, regions, and platforms to uncover patterns in community growth, engagement, tournaments, and demographics. The analysis spans four sessions: loading & inspection, data cleaning, grouping/aggregation/feature engineering, and visualisation.

---

## 📁 Dataset

| File | Rows | Columns | Notes |
|------|------|---------|-------|
| `gaming_communities.csv` | 400 | 28 | Raw dataset |
| `gaming_communities_data_cleaned.csv` | 357 | 21 | Cleaned — 0 missing values |
| `gaming_communities_enhanced.csv` | 357 | 31+ | Enhanced with engineered features |

---

## 📂 Repository Structure

```
arena-gaming-eda/
├── gaming_communities.csv                          # Raw dataset
├── gaming_communities_data_cleaned.csv             # Cleaned dataset (Session 2 output)
├── gaming_communities_enhanced.csv                 # Enhanced dataset (Session 3 output)
├── ARENA_session_1.ipynb                           # Session 1 — Load & Inspect
├── ARENA_session_2_clean.ipynb                     # Session 2 — Data Cleaning
├── ARENA_session_3_groupby_feature_eng.ipynb       # Session 3 — GroupBy & Feature Engineering
├── ARENA_session_4_visulization.ipynb              # Session 4 — Visualisation (Matplotlib, Seaborn, Plotly)
├── arena.py                                        # Streamlit dashboard app
├── requirements.txt                                # Python dependencies
├── Data analysis of ARENA.docx                     # Written analysis report
└── README.md                                       # This file
```

---

## 🛠️ Installation & Setup

```bash
# 1. Clone the repository
git clone https://github.com/faizantoheed456/arena-gaming-eda.git
cd arena-gaming-eda

# 2. (Optional) Create a virtual environment
python -m venv venv
source venv/bin/activate        # Linux/Mac
venv\Scripts\activate           # Windows

# 3. Install required libraries
pip install -r requirements.txt

# 4. Launch Jupyter Notebook
jupyter notebook

# 5. (Optional) Run the Streamlit dashboard
streamlit run arena.py
```

---

## 📊 Sessions Overview

| Session | Focus | Notebook | Status |
|---------|-------|----------|--------|
| 1 | Data loading, inspection, missing value detection | `ARENA_session_1.ipynb` | ✅ Complete |
| 2 | Data cleaning, imputation, outlier capping, type conversion | `ARENA_session_2_clean.ipynb` | ✅ Complete |
| 3 | Grouping, aggregations, feature engineering, pivot tables | `ARENA_session_3_groupby_feature_eng.ipynb` | ✅ Complete |
| 4 | Visualisation — Matplotlib, Seaborn, Plotly (28 charts) | `ARENA_session_4_visulization.ipynb` | ✅ Complete |

---

## 📈 Session 4 — Visualisation Breakdown

Session 4 produces **28 charts** split across three libraries:

**Matplotlib (10 charts)**

| ID | Chart | Question Answered |
|----|-------|-------------------|
| M1 | Histogram of `log_member_count` + KDE | How are community sizes distributed? |
| M2 | Horizontal bar chart of mean engagement per genre | Which genres drive the highest engagement? |
| M3 | Scatter plot with trendline, coloured by tier | How does community size relate to active players? |
| M4 | Boxplot of `tournament_intensity` by platform | How does platform affect tournament activity? |
| M5 | Dual-axis plot: community age (line) vs social presence (bars) | Do older communities have stronger social presence? |
| M6 | Violin plot of `avg_member_age` by region | How does member age vary across regions? |
| M7 | Stacked bar chart of community tiers per genre | What is the tier composition within each genre? |
| M8 | Error bar chart of mean coaching staff per tier | How does coaching investment scale with tier? |
| M9 | Hexbin heatmap of member count vs engagement ratio | Where do size and engagement cluster? |
| M10 | 2×2 subplot dashboard | Multi-metric overview |

**Seaborn (8 charts)**

| ID | Chart |
|----|-------|
| S1 | Pairplot of key numeric columns coloured by genre |
| S2 | FacetGrid histograms of engagement ratio by region & tier |
| S3 | Jointplot with KDE and marginal histograms |
| S4 | Boxen plot of `avg_member_age` by region |
| S5 | Correlation heatmap with mask |
| S6 | FacetGrid: violin + stripplot of tournament intensity by genre |
| S7 | Regression plot with confidence band (member count vs social presence) |
| S8 | Normalised count plot of coaching percentage per genre |

**Plotly Interactive (10 charts, exported as HTML)**

| ID | Chart |
|----|-------|
| P1 | Interactive bar chart of mean engagement per region with error bars |
| P2 | Interactive scatter: size = social presence, colour = tier |
| P3 | 3D scatter: member count × engagement × tournament intensity |
| P4 | Sunburst chart: region → genre → tier |
| P5 | Interactive line chart of cumulative members for top 3 genres |
| P6 | Box plot with all points and notch by tier |
| P7 | Histogram of log member count with marginal rug by platform |
| P8 | Density heatmap (member count vs active players) with marginals |
| P9 | Horizontal bar chart of top 15 countries by total members |
| P10 | `make_subplots` dashboard: scatter + histogram (coaching split) |

---

## 🔍 Key Insights

**From Session 3**
- **Engagement:** Battle Royale and MMORPG have the highest active-player ratios (~45%).
- **Tier distribution:** Asia has the highest average tier score (1.63); South America the lowest (1.37).
- **Coaching:** 100% of Elite & Professional communities have coaching; 0% of Amateur do.
- **Tournaments:** Semi-Pro communities host the most tournaments (525 total).
- **Language:** English dominates (141 communities), followed by Spanish (62) and Portuguese (32).
- **Social presence:** `Pulse Nation` has the highest total social presence (Discord + Reddit + content creators).
- **Oldest communities:** In EU, a community was founded in 2008 (18 years old).
- **Regional inequality:** Only 18.8% of communities have member counts above their region's average.

**From Session 4 Visualisations**
- Log member count follows a near-normal distribution, indicating healthy diversity in community sizes.
- Coaching investment scales clearly with tier — visible in both the error bar chart and the FacetGrid breakdown.
- The 3D scatter reveals a strong positive cluster between high member count, engagement, and tournament intensity at Elite tier.
- The sunburst chart exposes regional genre concentration: certain regions are dominated by one or two genres.

---

## 🧪 How to Reproduce the Analysis

1. Open `ARENA_session_1.ipynb` — run all cells to inspect the raw data.
2. Open `ARENA_session_2_clean.ipynb` — run all cells to produce `gaming_communities_data_cleaned.csv`.
3. Open `ARENA_session_3_groupby_feature_eng.ipynb` — run all cells to produce `gaming_communities_enhanced.csv`.
4. Open `ARENA_session_4_visulization.ipynb` — run all cells to generate all 28 charts (Plotly charts also save as `.html`).
5. Refer to `Data analysis of ARENA.docx` for the written findings and interpretation.
6. Run `streamlit run arena.py` for the interactive dashboard.

---

## 📄 License

This project is for educational purposes. The dataset is synthetic/inspired by real-world gaming communities.

---

## 👤 Author

**Faizan Toheed** — Lead Analyst (sole contributor)
