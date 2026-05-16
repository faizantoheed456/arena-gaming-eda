# 🎮 ARENA – Gaming Communities EDA

**Exploratory Data Analysis of 400+ gaming communities worldwide.**

This is the ARENA project – a unified platform to analyse fragmented gaming communities. The goal is to uncover patterns in community growth, engagement, revenue, tournaments, and player demographics.

---

## 📁 Dataset

- **Raw file:** `gaming_communities.csv` (400 rows, 28 columns)
- **Cleaned file:** `gaming_communities_data_cleaned.csv` (357 rows, 21 columns, 0 missing values)
- **Features:** member_count, active_players, genre, region, monthly_revenue_usd, win_rate_pct, sponsorship, tournaments_hosted, etc.

---

## 📌 Sessions Completed

| Session | Focus | Notebook | Status |
| :--- | :--- | :--- | :--- |
| 1 | Data loading & inspection | `ARENA_session_1.ipynb` | ✅ Complete |
| 2 | Data cleaning & preprocessing | `ARENA_session_2_clean.ipynb` | ✅ Complete |
| 3 | GroupBy, aggregations & feature engineering | *(to be created)* | ⏳ Next |
| 4 | Visualisations & statistics | *(to be created)* | ⏳ Planned |

---

## 🧹 Cleaning Summary (Session 2)

- **Rows dropped:** 43 (missing `active_players`)
- **Columns dropped:**
  - **4 high‑null (>60%):** `average_prize_pool_usd`, `twitch_stream_viewers_avg`, `win_rate_pct`, `monthly_revenue_usd`
  - **3 zero‑variance:** `sponsorship`, `verified_account`, `recruitment_open` (after boolean conversion)
- **Missing values imputed:** median for `avg_member_age`, `'None'` for `secondary_game`, `0` for platform sizes, `'Unknown'` for region/country
- **Outliers capped:** `member_count` at 99th percentile (68,819)
- **Impossible years removed:** 3005, 2087 → replaced with NaN → forward‑filled
- **Data types optimised:** int64 → float32, object → category where appropriate
- **Final shape:** 357 rows × 21 columns, **0 nulls**

---

## 🛠️ Tools & Libraries

- Python 3.10+
- pandas, numpy
- (matplotlib, seaborn, plotly for later sessions)

---

## 📂 Repository Structure

```text
arena-gaming-eda/
├── gaming_communities.csv              # raw dataset
├── gaming_communities_data_cleaned.csv # cleaned dataset (Session 2 output)
├── ARENA_session_1.ipynb               # Session 1: loading & inspection
├── ARENA_session_2_clean.ipynb         # Session 2: data cleaning
└── README.md                           # this file


