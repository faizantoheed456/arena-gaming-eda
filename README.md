# 🎮 ARENA – Gaming Communities EDA

**Exploratory Data Analysis of 400+ gaming communities worldwide.**

This is the first session of the ARENA project – a unified platform to analyse fragmented gaming communities. The goal is to uncover patterns in community growth, engagement, revenue, tournaments, and player demographics.

---

## 📁 Dataset

- **File:** `gaming_communities.csv`
- **Rows:** 400 gaming communities
- **Columns:** 28 (member_count, active_players, genre, region, monthly_revenue_usd, win_rate_pct, sponsorship, tournaments_hosted, etc.)
- **Features:** Real‑world inspired data with intentional missing values, outliers, and inconsistencies for robust practice.

---

## 📌 Session 1 – Loading & Inspection

In this session, I completed the first 15 steps of the 221‑question EDA guide:

- Loaded data with pandas
- Inspected shape, columns, data types
- Checked missing values and memory usage
- Generated statistical summaries (`.describe()`)
- Sampled random rows, previewed head/tail
- Identified numeric vs object columns
- Listed columns with nulls
- Calculated memory footprint (0.32 MB)
- Found most unique column (`community_id`)
- Used `.iloc` to extract first 3 rows and last 3 columns
- Counted communities per genre (FPS leads with 174)
- Extracted index range (0–399)

All observations and code are documented in the notebook.

---

## 🛠️ Tools & Libraries

- Python 3.10+
- pandas
- numpy

---

## 📂 Repository Structure
arena-gaming-eda/
├── gaming_communities.csv # raw dataset
├── ARENA_session_1.ipynb # Jupyter notebook with complete Session 1
├── README.md # this file
└── (future notebooks will be added)


---

## 🚀 How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/arena-gaming-eda.git
   cd arena-gaming-eda

2. (Optional) Create and activate a virtual environment.

3. Install dependencies:
pip install pandas numpy

4. Launch Jupyter Notebook:
jupyter notebook

Open ARENA_session_1.ipynb and run cells sequentially.

