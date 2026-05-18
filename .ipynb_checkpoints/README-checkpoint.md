# 🎮 ARENA – Gaming Communities EDA

![Python](https://img.shields.io/badge/Python-3.8%2B-blue?logo=python&logoColor=white)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-orange?logo=jupyter&logoColor=white)
![pandas](https://img.shields.io/badge/pandas-2.x-150458?logo=pandas&logoColor=white)
![Plotly](https://img.shields.io/badge/Plotly-interactive-3F4F75?logo=plotly&logoColor=white)
![Status](https://img.shields.io/badge/Session%204-Planned-yellow)
![License](https://img.shields.io/badge/License-Educational-green)

> **Exploratory Data Analysis of 400+ gaming communities worldwide.**  
> Uncovering patterns in community growth, engagement, tournaments, and demographics — across genres, tiers, regions, and platforms.

---

## 📑 Table of Contents

- [About the Project](#-about-the-project)
- [Dataset](#-dataset)
- [Repository Structure](#-repository-structure)
- [Tech Stack](#-tech-stack)
- [Sessions Overview](#-sessions-overview)
- [Key Insights](#-key-insights-from-session-3)
- [Getting Started](#-getting-started)
- [How to Reproduce](#-how-to-reproduce-the-analysis)
- [Project Team](#-project-team)
- [License](#-license)

---

## 📖 About the Project

ARENA is a multi-session data analysis project built on a rich dataset of 400+ gaming communities. Each session progressively transforms raw data into actionable insights:

- **Session 1** — Load and inspect the raw data, detect missing values and data types
- **Session 2** — Clean, impute, cap outliers, and convert types
- **Session 3** — Group, aggregate, engineer new features, and build pivot tables
- **Session 4** *(planned)* — Visualise with Matplotlib, Seaborn & Plotly; run statistical tests

The project is designed to be fully reproducible — each notebook picks up where the last one left off.

---

## 📁 Dataset

| File | Rows | Columns | Description |
|------|------|---------|-------------|
| `gaming_communities.csv` | 400 | 28 | Raw dataset |
| `gaming_communities_data_cleaned.csv` | 357 | 21 | Cleaned, 0 missing values (Session 2 output) |
| `gaming_communities_enhanced.csv` | 357 | 31+ | Feature-engineered dataset (Session 3 output) |

> The dataset is synthetic, inspired by real-world gaming community data.

---

## 📂 Repository Structure

```
arena-gaming-eda/
├── gaming_communities.csv                        # Raw dataset
├── gaming_communities_data_cleaned.csv           # Cleaned dataset (Session 2)
├── gaming_communities_enhanced.csv              # Enhanced dataset (Session 3)
├── ARENA_session_1.ipynb                         # Session 1: Load & Inspect
├── ARENA_session_2_clean.ipynb                   # Session 2: Data Cleaning
├── ARENA_session_3_groupby_feature_eng.ipynb     # Session 3: Groupby & Feature Eng.
├── Data analysis of ARENA.docx                  # Written analysis report
└── README.md                                     # You are here
```

> Session 4 notebook will be added upon completion.

---

## 🛠️ Tech Stack

| Library | Purpose |
|---------|---------|
| `pandas` | Data loading, cleaning, grouping, aggregation |
| `NumPy` | Numerical operations and array handling |
| `Matplotlib` | Static plotting (Session 4) |
| `Seaborn` | Statistical visualisations (Session 4) |
| `Plotly` | Interactive charts (Session 4) |
| `SciPy` | Statistical tests (Session 4) |

---

## 📊 Sessions Overview

| # | Focus | Notebook | Status |
|---|-------|----------|--------|
| 1 | Data loading, inspection, missing value detection | `ARENA_session_1.ipynb` | ✅ Complete |
| 2 | Data cleaning, imputation, outlier capping, type conversion | `ARENA_session_2_clean.ipynb` | ✅ Complete |
| 3 | Grouping, aggregations, feature engineering, pivot tables | `ARENA_session_3_groupby_feature_eng.ipynb` | ✅ Complete |
| 4 | Visualisation (Matplotlib, Seaborn, Plotly) & statistics | *coming soon* | ⏳ Planned |

---

## 🔍 Key Insights from Session 3

| Finding | Detail |
|---------|--------|
| 🎯 **Top genres by engagement** | Battle Royale & MMORPG lead with ~45% active-player ratios |
| 🌍 **Regional tier scores** | Asia tops at 1.63 avg; South America trails at 1.37 |
| 🏆 **Coaching availability** | 100% of Elite & Pro communities offer coaching; 0% of Amateur |
| ⚔️ **Tournament leaders** | Semi-Pro communities host the most tournaments (525 total) |
| 🗣️ **Language dominance** | English (141 communities) › Spanish (62) › Portuguese (32) |
| 📣 **Highest social presence** | `Pulse Nation` tops Discord + Reddit + content creator reach |
| 🕰️ **Oldest community** | Founded 2008 in the EU region (18 years old) |
| 📉 **Regional inequality** | Only 18.8% of communities exceed their region's average member count |

---

## 🚀 Getting Started

### Prerequisites

- Python 3.8+
- Jupyter Notebook or JupyterLab

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/faizantoheed456/arena-gaming-eda.git
cd arena-gaming-eda

# 2. (Optional) Create and activate a virtual environment
python -m venv venv
source venv/bin/activate        # Linux / macOS
venv\Scripts\activate           # Windows

# 3. Install required libraries
pip install pandas numpy matplotlib seaborn plotly scipy

# 4. Launch Jupyter Notebook
jupyter notebook
```

---

## 🧪 How to Reproduce the Analysis

Run the notebooks **in order** — each one depends on the output of the previous:

1. **Session 1** → Open `ARENA_session_1.ipynb` and run all cells to inspect the raw data.
2. **Session 2** → Open `ARENA_session_2_clean.ipynb` and run all cells to produce `gaming_communities_data_cleaned.csv`.
3. **Session 3** → Open `ARENA_session_3_groupby_feature_eng.ipynb` and run all cells to produce `gaming_communities_enhanced.csv`.
4. **Session 4** *(planned)* → Use `gaming_communities_enhanced.csv` for visualisation and statistical testing.

---

## 👤 Project Team

| Name | Role |
|------|------|
| **Faizan Toheed** | Lead Analyst (sole contributor) |

---

## 📄 License

This project is for **educational purposes only**. The dataset is synthetic and inspired by real-world gaming communities. Feel free to fork, explore, and build on it.

---

*Part of the **ARENA** project.*