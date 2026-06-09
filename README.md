<div align="center">

# 🎮 ARENA
### **Aggregated Regional & Esports Network Analytics**

*A full-stack database engineering project — from raw CSV to production-ready MySQL schema*

---

![Python](https://img.shields.io/badge/Python-3.10%2B-3776AB?style=for-the-badge&logo=python&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-F37626?style=for-the-badge&logo=jupyter&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-2.x-150458?style=for-the-badge&logo=pandas&logoColor=white)
![Plotly](https://img.shields.io/badge/Plotly-Interactive-3F4F75?style=for-the-badge&logo=plotly&logoColor=white)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)

</div>

---

## 📖 Table of Contents

- [Project Overview](#-project-overview)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Dataset Summary](#-dataset-summary)
- [EDA Sessions](#-eda-sessions)
- [Database Design](#-database-design)
- [SQL Implementation](#-sql-implementation)
- [Analytical Queries](#-analytical-queries)
- [EDA Outputs Gallery](#-eda-outputs-gallery)
- [Setup & Installation](#-setup--installation)
- [File Execution Order](#-file-execution-order)
- [Schema Summary](#-schema-summary)
- [Key Findings](#-key-findings)
- [Known Gaps](#-known-gaps)
- [Author](#-author)

---

## 🏟️ Project Overview

**ARENA** is a unified analytics platform that aggregates data from **400 gaming communities worldwide**. It tracks membership size, active player ratios, tournament activity, social media footprint, and game assignments for the most competitive communities globally.

This project demonstrates a complete **database engineering pipeline**:

| Phase | Description |
|-------|-------------|
| 🔍 **EDA** | Exploratory Data Analysis across 4 Jupyter sessions |
| 🗂️ **Modelling** | Entity identification, ER modelling (Crow's Foot notation) |
| 🔧 **Normalisation** | UNF → 1NF → 2NF → 3NF decomposition |
| 🛢️ **SQL** | Full MySQL implementation across 5 structured script files |
| 📊 **Analytics** | 12 analytical queries (joins, window functions, subqueries) |

---

## 🛠 Tech Stack

| Tool | Purpose |
|------|---------|
| **Python 3.10+** | EDA, data cleaning, feature engineering |
| **Pandas / NumPy** | Data manipulation and aggregation |
| **Matplotlib / Seaborn** | Static visualisations |
| **Plotly** | Interactive charts and dashboards |
| **MySQL 8.0** | Relational database engine |
| **Jupyter Notebook** | EDA sessions (`.ipynb`) |
| **VS Code** | Development environment |
| **Dev Container** | Reproducible workspace (`.devcontainer`) |

---

## 📁 Project Structure

```
ARENA/
│
├── .devcontainer/                  # VS Code Dev Container configuration
│   └── devcontainer.json
│
├── .ipynb_checkpoints/             # Auto-saved Jupyter checkpoints
│
├── csv_files/                      # Raw and processed datasets
│   ├── gaming_communities.csv              # Original raw dataset (400 rows × 28 cols)
│   ├── gaming_communities_data_cleaned.csv # Post-cleaning dataset (357 rows × 22 attrs)
│   └── gaming_communities_enhanced.csv     # Final dataset with 10 engineered features
│
├── EDA_Notebooks/                  # Jupyter EDA sessions
│   ├── ARENA_session_1.ipynb               # Dataset loading & inspection
│   ├── ARENA_session_2_clean.ipynb         # Data cleaning & preprocessing
│   ├── ARENA_session_3_groupby_feature_eng.ipynb  # Aggregations & feature engineering
│   └── ARENA_session_4_visulization.ipynb  # Key visualisation findings
│
├── EDA_Output/                     # All generated charts & reports
│   ├── 3d_scatter.html
│   ├── ARENA_Enhanced_Analysis_Report.pdf
│   ├── ARENA_Gaming_Communities_Report.pdf
│   ├── ARENA_Project_Summary.pdf
│   ├── box_tournament_intensity_by_tier.html
│   ├── cumulative_growth_top3_genres.html
│   ├── dashboard_scatter_histogram.html
│   ├── fig_coaching_by_tier.html
│   ├── fig_correlation_heatmap.png
│   ├── fig_genre_distribution.png
│   ├── fig_languages.png
│   ├── fig_member_distribution.png
│   ├── fig_member_vs_active.html
│   ├── fig_region_distribution.png
│   ├── fig_tier_distribution.png
│   ├── hist_log_member_count_by_platform.html
│   ├── region_engagement_analysis.html
│   ├── scatter_social_presence.html
│   ├── sunburst_region_genre_tier.html
│   └── top_15_countries_members.html
│
├── MySQL_Files/                    # SQL scripts (execute in order)
│   ├── 01_platforms_and_games.sql          # Lookup tables: platforms, genres, games
│   ├── 02_locations_and_countries.sql      # Geographic hierarchy: language→country→location
│   ├── 03_communities.sql                  # Core community tables + 3 reporting views
│   ├── 04_queries.sql                      # 12 analytical SELECT queries
│   └── 05_add_constraints_and_indexes.sql  # CHECK constraints, NOT NULL, UNIQUE, indexes
│
├── Reports/                        # Written project reports (Word)
│   ├── ARENA_Database_Concised.docx
│   ├── ARENA_Database_Final.docx
│   ├── ARENA_Report_Concise.docx
│   ├── dbs project enitites and attributes tabular.docx
│   └── Normalization.docx
│
├── SQL_Output/                     # Query result exports (Excel)
│   ├── 01_communities_by_region_and_platform.xlsx
│   ├── 02_metrics_by_community_tier.xlsx
│   ├── 03_high_engagement_communities.xlsx
│   ├── 04_community_game_genre_and_social_reach.xlsx
│   ├── 05_communities_above_regional_average.xlsx
│   ├── 06_top_tier_tournament_hosts.xlsx
│   ├── 07_mature_and_large_regions.xlsx
│   ├── 08_active_player_rankings_by_tier.xlsx
│   ├── 09_top_10_total_social_presence.xlsx
│   ├── 10_game_variety_per_community.xlsx
│   ├── 11_supported_and_active_communities.xlsx
│   ├── 12_shared_primary_games_cross_reference.xlsx
│   ├── Community Game Assignments.xlsx
│   ├── Community Metrics Dashboard.xlsx
│   ├── Complete Community Profiles.xlsx
│   ├── Games and Genres.xlsx
│   ├── Location, Country, and Language Mapping.xlsx
│   ├── Platforms and Classifications.xlsx
│   └── Social Platforms.xlsx
│
├── arena_dashboard.py              # Python dashboard script
├── ARENA_Database_Architecture (2) (1).pptx   # Architecture slide deck
└── requirements.txt                # Python dependencies
```

---

## 📊 Dataset Summary

| Item | Detail |
|------|--------|
| **Source File** | `gaming_communities.csv` |
| **Original Shape** | 400 rows × 28 columns |
| **After Cleaning** | 357 valid rows, 22 attributes |
| **Numeric Columns** | 15 (`float64` / `int64`) |
| **Object Columns** | 13 (categorical / text) |
| **Final DB Tables** | 16 physical tables + 3 reporting views |
| **Unique Communities** | 357 (after deduplication) |
| **Geographic Coverage** | 24 countries, 10 languages, multiple regions |

---

## 🔬 EDA Sessions

### Session 1 — Dataset Loading & Inspection (`ARENA_session_1.ipynb`)

- Loaded raw CSV into a Pandas DataFrame (400 rows × 28 cols)
- Identified high-null columns: `twitch_stream_viewers_avg` (302 nulls), `monthly_revenue_usd` (302 nulls), `win_rate_pct` (288 nulls)
- Confirmed `community_id` as unique identifier (400 distinct values)
- Top genres: **FPS > Battle Royale > MOBA**
- Detected anomaly: `year_founded` contained impossible future values (e.g., 3005, 2087)

---

### Session 2 — Data Cleaning & Preprocessing (`ARENA_session_2_clean.ipynb`)

| Transformation | Detail |
|----------------|--------|
| Drop null rows | Dropped rows with null `active_players` → 357 rows remaining |
| Fill nulls | `avg_member_age` nulls → filled with column median |
| Drop sparse cols | Columns > 60% null dropped (`average_prize_pool_usd`, `twitch_stream_viewers_avg`, `win_rate_pct`, `monthly_revenue_usd`) |
| Fix `year_founded` | Forward-filled; future years (> 2026) replaced with `NaN`; cast to `Int64` |
| Clip outliers | `member_count` clipped at 99th percentile |
| Remove zero-variance | Removed `sponsorship`, `verified_account`, `recruitment_open` |
| Fill remaining nulls | `region`/`country` → `'Unknown'`; `tournaments_hosted` → `0` |
| Reset IDs | `community_id` reset to sequential range 1–357 |

**Final null count: 0**

---

### Session 3 — Grouping, Aggregations & Feature Engineering (`ARENA_session_3_groupby_feature_eng.ipynb`)

**Key aggregation findings:**

- 🥊 **Fighting** genre had the highest average member count (~5,596 members)
- 🏆 **SemiPro** tier hosted the most tournaments (525 total)
- 🐦 **Twitter/X** had the highest median active players per platform (311.0)
- 🌐 Top languages: **English** (141), **Spanish** (62), **Portuguese** (32)
- 🌏 **Asia + Twitch** pairing had the highest average active players (~3,696)
- 📊 Only **18.8%** of communities exceeded their regional average member count

**10 Engineered Features:**

| Feature Column | Formula / Method | Key Insight |
|----------------|-----------------|-------------|
| `engagement_ratio` | `active_players / member_count` | Battle Royale & MMORPG highest (~0.45) |
| `tier_score` | Amateur=1 … Elite=4 (ordinal map) | Asia had highest avg tier (1.63) |
| `age_group` | `pd.cut()` on `avg_member_age` [0,18,25,35,100+] | Teen / Young Adult / Adult / Senior |
| `community_age` | `2025 − year_founded` | Measures organisational maturity |
| `has_coaching` | `True` if `coaching_staff > 0` | 100% of Elite/Professional have coaching |
| `has_multiple_platforms` | `discord > 0 AND reddit > 0` | Only 51.5% maintain both channels |
| `log_member_count` | `np.log1p(member_count)` | Confirms log-normal distribution |
| `tournament_intensity` | `tournaments / (member_count / 1000)` | Normalised competitive activity rate |
| `top_player_tier` | `pd.qcut()` into 3 quantiles | High / Medium / Low ranking tiers |
| `total_social_presence` | `discord + reddit + (creators × 1000)` | *Pulse Nation* highest at 123,596 |

---

### Session 4 — Key Visualisation Findings (`ARENA_session_4_visulization.ipynb`)

| Chart | Finding |
|-------|---------|
| M1 Histogram | `log_member_count` is roughly bell-shaped (log-normal); clusters between log values 6–9 |
| M2 Bar Chart | Battle Royale and MMORPG have the highest average engagement ratios |
| M3 Scatter | Strong positive linear relationship between `member_count` and `active_players`; Elite communities deviate above the trendline |
| M4 Boxplot | Discord and Reddit show the widest spread in `tournament_intensity` |
| M5 Dual-axis | Older communities generally show higher social presence; some young communities exhibit rapid early growth |
| M6 Violin | Average member ages broadly similar across regions (20–32); EU shows wider spread |
| Plotly Interactive | Discord confirmed as the dominant primary platform across all regions |

---

## 🗄️ Database Design

### Logical Entities (Pre-Normalisation)

| Entity | Description | Primary Key | Foreign Key(s) |
|--------|-------------|-------------|----------------|
| `COMMUNITY` | Core profile, sizes, and performance metrics | `community_id` | `location_id`, `platform_id` |
| `GAME` | Master list of distinct video games | `game_id` | None |
| `LOCATION` | Geographic & demographic attributes | `location_id` | None |
| `PLATFORM` | Communication platforms used as hubs | `platform_id` | None |
| `COMMUNITY_GAME` | Junction table: Community ↔ Game (M:N) | `(community_id, game_id)` | `community_id`, `game_id` |

### Relationships & Cardinality

| Left Entity | Right Entity | Cardinality | Business Rule |
|-------------|-------------|-------------|---------------|
| `LOCATION` | `COMMUNITY` | 1 : N | One location hosts many communities; each community has exactly one location |
| `PLATFORM` | `COMMUNITY` | 1 : N | One platform serves many communities; each community picks one primary hub |
| `COMMUNITY` | `COMMUNITY_GAME` | 1 : N | One community can have many game rows in the junction table |
| `GAME` | `COMMUNITY_GAME` | 1 : N | One game can appear across many communities |
| `COMMUNITY` | `GAME` (via junction) | M : N | Many communities play many games — resolved through `COMMUNITY_GAME` |

### Normalisation Journey

```
UNF (Flat CSV)
    └─► 1NF  — Atomic values; single-valued columns; unique row identifiers
         └─► 2NF  — Removed partial dependencies on composite keys
              └─► 3NF  — Removed transitive dependencies (e.g., country → language)
```

**Final result: 16 physical tables** — all in Third Normal Form (3NF).

### Physical Schema (Post-3NF — 16 Tables)

| Table | Purpose | PK | FK(s) → References |
|-------|---------|----|--------------------|
| `COMMUNITY` | Core community profile | `community_id` | `region_id` → `COMMUNITY_REGION`; `gaming_platform_id` → `GAMING_PLATFORM` |
| `COMMUNITY_MEMBERSHIP` | Member & active player counts | `membership_id` | `community_id` → `COMMUNITY` |
| `COMMUNITY_COMPETITION` | Tournaments & top player rank | `competition_id` | `community_id` → `COMMUNITY` |
| `COMMUNITY_STAFF` | Coaching & content creator counts | `staff_id` | `community_id` → `COMMUNITY` |
| `COMMUNITY_SOCIAL_MEDIA` | Per-platform social media sizes | `community_social_id` | `community_id`, `social_platform_id` |
| `COMMUNITY_GAME` | Junction: community ↔ game (M:N) | `(community_id, game_id)` | `community_id`, `game_id` |
| `COMMUNITY_REGION` | Region lookup for communities | `region_id` | — |
| `GAMING_PLATFORM` | Gaming hub lookup | `gaming_platform_id` | — |
| `GAME` | Video game master list | `game_id` | `genre_id` → `GENRE` |
| `GENRE` | Genre classification lookup | `genre_id` | — |
| `SOCIAL_PLATFORM` | Social channel name lookup | `social_platform_id` | — |
| `COUNTRY_LOCATION` | Country-to-continent mapping | `location_id` | `country_id` → `COUNTRY` |
| `COUNTRY` | Country name & language mapping | `country_id` | `language_id` → `LANGUAGE` |
| `LANGUAGE` | Language name lookup | `language_id` | — |
| `PLATFORM` | Communication platform lookup | `platform_id` | `platform_type_id` → `PLATFORM_TYPE` |
| `PLATFORM_TYPE` | Platform category lookup | `platform_type_id` | — |

---

## 🛢️ SQL Implementation

### File Execution Order

> ⚠️ **Scripts must be executed in this exact order** — each file depends on the tables created by the previous one.

```
01_platforms_and_games.sql
        ↓
02_locations_and_countries.sql
        ↓
03_communities.sql
        ↓
04_queries.sql          ← read-only; safe to re-run anytime
        ↓
05_add_constraints_and_indexes.sql
```

---

### File 01 — Platforms & Games

**Tables created:** `PLATFORM_TYPE`, `PLATFORM`, `GENRE`, `GAME`, `SOCIAL_PLATFORM`

**Key design decisions:**
- `PLATFORM_TYPE` separates platform categories (Forum, VoIP, Streaming, Social Media) from platform names, eliminating the transitive dependency found in the original `PLATFORM` table
- `GAME` references `GENRE` via `genre_id` FK (`ON DELETE SET NULL`) — genre deletion does not cascade-delete game records
- 17 game titles inserted across 6 genres: **FPS, MOBA, Battle Royale, Sports, MMORPG, Fighting**
- `SET FOREIGN_KEY_CHECKS = 0/1` wraps all `DROP TABLE` statements to allow safe re-execution in any order

```sql
CREATE TABLE `GAME` (
    `game_id`   INT AUTO_INCREMENT PRIMARY KEY,
    `game_name` VARCHAR(255) NOT NULL,
    `genre_id`  INT,
    FOREIGN KEY (`genre_id`) REFERENCES `GENRE`(`genre_id`)
        ON DELETE SET NULL ON UPDATE CASCADE
);
```

---

### File 02 — Locations & Countries

**Tables created:** `LANGUAGE`, `COUNTRY`, `COUNTRY_LOCATION`

**Key design decisions:**
- Full 3NF geographic hierarchy: `LANGUAGE → COUNTRY → COUNTRY_LOCATION`
- 24 countries across 10 languages (English, Korean, Japanese, French, German, Chinese, Portuguese, Spanish, Arabic, Russian)
- 6 language corrections applied during data entry (e.g., Chile/Argentina: Portuguese → Spanish)
- Table named `COUNTRY_LOCATION` (not `LOCATION`) to avoid naming conflict with the community region lookup

```sql
CREATE TABLE `COUNTRY` (
    `country_id`   INT AUTO_INCREMENT PRIMARY KEY,
    `country_name` VARCHAR(100) NOT NULL,
    `language_id`  INT,
    FOREIGN KEY (`language_id`) REFERENCES `LANGUAGE`(`language_id`)
        ON DELETE SET NULL ON UPDATE CASCADE
);
```

---

### File 03 — Communities

**Tables created:** `COMMUNITY_REGION`, `GAMING_PLATFORM`, `COMMUNITY`, `COMMUNITY_MEMBERSHIP`, `COMMUNITY_COMPETITION`, `COMMUNITY_STAFF`, `COMMUNITY_SOCIAL_MEDIA`, `COMMUNITY_GAME`

**Key design decisions:**
- `COMMUNITY_REGION` stores 100 region entries (broad → country-specific)
- `GAMING_PLATFORM` renamed from `PLATFORM` to avoid naming conflict with file 01
- Satellite tables use surrogate PKs with `NOT NULL` FK to `COMMUNITY`
- `COMMUNITY_GAME` uses composite PK `(community_id, game_id)` to prevent duplicate pairs

**Reporting Views created:**

| View Name | Description |
|-----------|-------------|
| `vw_complete_community_profiles` | Flat profile row with region and platform names resolved |
| `vw_community_metrics_dashboard` | Full operational dashboard row per community (membership + competition + staff) |
| `vw_community_game_assignments` | Each game assignment alongside community name and play designation |

```sql
CREATE TABLE `COMMUNITY_GAME` (
    `community_id`     INT NOT NULL,
    `game_id`          INT NOT NULL,
    `play_designation` VARCHAR(100),
    PRIMARY KEY (`community_id`, `game_id`),
    FOREIGN KEY (`community_id`) REFERENCES `COMMUNITY`(`community_id`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`game_id`) REFERENCES `GAME`(`game_id`)
        ON DELETE CASCADE ON UPDATE CASCADE
);
```

---

### File 05 — Constraints & Indexes

**Phase 1 — CHECK Constraints & DEFAULT Values**

| Constraint | Rule Enforced |
|------------|---------------|
| `chk_community_tier` | `community_tier IN ('Amateur', 'Semi-Pro', 'Professional', 'Elite')` |
| `chk_avg_member_age` | `avg_member_age BETWEEN 0 AND 100` |
| `chk_year_founded` | `year_founded BETWEEN 1900 AND 2100` |
| DEFAULT values | `member_count`, `active_players`, `tournaments_hosted`, `coaching_staff`, `content_creators` all default to `0` |

**Phase 2 — NOT NULL & UNIQUE Constraints**

| UNIQUE Constraint | Effect |
|-------------------|--------|
| `uq_membership_comm` | Prevents more than one membership row per community |
| `uq_competition_comm` | Prevents duplicate competition rows |
| `uq_staff_comm` | Prevents duplicate staff rows |

**Phase 3 — Performance Indexes (22 total)**

| Index Group | Indexes |
|-------------|---------|
| FK Indexes (3.1) | `idx_community_region`, `idx_community_platform`, `idx_membership_comm`, `idx_competition_comm`, `idx_community_staff_comm`, `idx_community_social_comm`, `idx_community_game_comm`, `idx_community_game_game` |
| Filter Columns (3.2) | `idx_community_tier`, `idx_community_year`, `idx_membership_member_count`, `idx_membership_active_players`, `idx_competition_tournaments`, `idx_competition_top_rank` |
| Lookup Names (3.3) | `idx_region_name`, `idx_game_name`, `idx_genre_name`, `idx_country_name`, `idx_language_name` |
| Composite (3.4) | `idx_comm_tier_age` on `(community_tier, avg_member_age)` |

---

## 📋 Analytical Queries

12 read-only `SELECT` queries in `04_queries.sql` covering a full range of SQL techniques:

| # | Query Type | Description |
|---|-----------|-------------|
| Q1 | Two-table INNER JOIN | Top 10 communities by active players (> 500), sorted descending |
| Q2 | LEFT JOIN (missing data) | Communities with no region assigned (NULL check) |
| Q3 | GROUP BY + AVG/COUNT | Per-tier community count, average members, average active players |
| Q4 | GROUP BY + HAVING | Tiers where total tournaments hosted exceed 100 |
| Q5 | Uncorrelated Subquery | Communities with `avg_member_age` above overall dataset average |
| Q6 | Correlated Scalar Subquery | Number of games each community plays (top 10 by game count) |
| Q7 | ROW_NUMBER() Window | Ranks all communities by member count (largest first) |
| Q8 | RANK() with PARTITION BY | Ranks communities by active players within each competitive tier |
| Q9 | 4-Table JOIN | Each community's primary game and genre |
| Q10 | Aggregate + Multi-JOIN | Per-region: community count, total members, avg tournaments |
| Q11 | EXISTS Subquery | Communities with at least one tournament AND coaching staff |
| Q12 | Self-JOIN via Junction | Pairs of communities sharing the same primary game (no duplicates) |

**Sample — Q8 Window Function:**
```sql
SELECT c.community_name, c.community_tier, m.active_players,
       RANK() OVER (PARTITION BY c.community_tier
                   ORDER BY m.active_players DESC) AS rank_in_tier
FROM COMMUNITY c
JOIN COMMUNITY_MEMBERSHIP m ON c.community_id = m.community_id
ORDER BY c.community_tier, rank_in_tier
LIMIT 30;
```

**Sample — Q12 Self-JOIN:**
```sql
SELECT g.game_name,
       c1.community_name AS community_1,
       c2.community_name AS community_2
FROM COMMUNITY_GAME cg1
JOIN COMMUNITY_GAME cg2 ON cg1.game_id = cg2.game_id
                       AND cg1.community_id < cg2.community_id
JOIN GAME g  ON cg1.game_id = g.game_id
JOIN COMMUNITY c1 ON cg1.community_id = c1.community_id
JOIN COMMUNITY c2 ON cg2.community_id = c2.community_id
WHERE cg1.play_designation = 'Primary'
  AND cg2.play_designation = 'Primary'
ORDER BY g.game_name LIMIT 25;
```

---

## 🖼️ EDA Outputs Gallery

All charts and reports are saved to `EDA_Output/`. Highlights include:

| File | Type | Content |
|------|------|---------|
| `fig_correlation_heatmap.png` | Static PNG | Correlation matrix of all numeric features |
| `fig_genre_distribution.png` | Static PNG | Bar chart of communities per genre |
| `fig_region_distribution.png` | Static PNG | Community count by region |
| `fig_tier_distribution.png` | Static PNG | Distribution across Amateur/Semi-Pro/Professional/Elite tiers |
| `3d_scatter.html` | Interactive | 3D scatter of member count, active players, and social presence |
| `sunburst_region_genre_tier.html` | Interactive | Hierarchical breakdown: Region → Genre → Tier |
| `top_15_countries_members.html` | Interactive | Top 15 countries by total membership |
| `region_engagement_analysis.html` | Interactive | Engagement ratio analysis by region |
| `cumulative_growth_top3_genres.html` | Interactive | Cumulative community growth for top 3 genres |
| `dashboard_scatter_histogram.html` | Interactive | Combined dashboard view |

---

## ⚙️ Setup & Installation

### Prerequisites

- Python 3.10+
- MySQL 8.0+
- Jupyter Notebook or VS Code with Jupyter extension

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/ARENA.git
cd ARENA
```

### 2. Install Python Dependencies

```bash
pip install -r requirements.txt
```

### 3. Set Up the MySQL Database

```bash
# Log into MySQL
mysql -u root -p

# Create the database
CREATE DATABASE arena_db;
USE arena_db;
```

### 4. Execute SQL Scripts in Order

```bash
mysql -u root -p arena_db < MySQL_Files/01_platforms_and_games.sql
mysql -u root -p arena_db < MySQL_Files/02_locations_and_countries.sql
mysql -u root -p arena_db < MySQL_Files/03_communities.sql
mysql -u root -p arena_db < MySQL_Files/04_queries.sql
mysql -u root -p arena_db < MySQL_Files/05_add_constraints_and_indexes.sql
```

### 5. Run EDA Notebooks

```bash
jupyter notebook EDA_Notebooks/
```

Open sessions in order: `session_1` → `session_2` → `session_3` → `session_4`

### 6. (Optional) Run the Dashboard

```bash
python arena_dashboard.py
```

---

## 📂 File Execution Order

```
┌─────────────────────────────────────────────────────┐
│  Step 1 │  01_platforms_and_games.sql               │
│         │  Creates: PLATFORM_TYPE, PLATFORM,        │
│         │           GENRE, GAME, SOCIAL_PLATFORM     │
├─────────────────────────────────────────────────────┤
│  Step 2 │  02_locations_and_countries.sql           │
│         │  Creates: LANGUAGE, COUNTRY,              │
│         │           COUNTRY_LOCATION                 │
├─────────────────────────────────────────────────────┤
│  Step 3 │  03_communities.sql                       │
│         │  Creates: All COMMUNITY_* tables          │
│         │  Inserts: 357 community rows              │
│         │  Creates: 3 reporting views               │
├─────────────────────────────────────────────────────┤
│  Step 4 │  04_queries.sql                           │
│         │  12 analytical SELECT queries             │
│         │  (read-only, safe to re-run anytime)      │
├─────────────────────────────────────────────────────┤
│  Step 5 │  05_add_constraints_and_indexes.sql       │
│         │  Adds: CHECK, NOT NULL, UNIQUE,           │
│         │        22 performance indexes             │
└─────────────────────────────────────────────────────┘
```

---

## 📐 Schema Summary

| Object Type | Count / Details |
|-------------|-----------------|
| **Physical Tables** | 16 |
| **Reporting Views** | 3 (`vw_complete_community_profiles`, `vw_community_metrics_dashboard`, `vw_community_game_assignments`) |
| **Foreign Keys** | 17 FK relationships enforcing referential integrity across all tables |
| **CHECK Constraints** | 11 (tier, age, year_founded, and non-negative numeric columns) |
| **UNIQUE Constraints** | 3 (enforcing 1:1 satellite relationships for membership, competition, and staff) |
| **Indexes** | 22 total (9 FK, 6 filter, 5 name-search, 1 composite, plus implicit unique indexes) |
| **Data Rows** | 357 community profiles; satellite data populated for IDs 1–200 |
| **Analytical Queries** | 12 (joins, aggregation, subqueries, window functions, EXISTS, self-joins) |

---

## 💡 Key Findings

- **FPS** is the most represented genre in the dataset
- **Fighting** genre communities are the largest by average member count (~5,596)
- **Elite and Professional** tier communities universally have coaching staff (100%)
- Only **51.5%** of communities maintain both Discord and Reddit channels
- **Asia + Twitch** is the most active region-platform combination (~3,696 avg active players)
- Just **18.8%** of communities exceed their regional average member count — the majority underperform regionally
- Member counts follow a **log-normal distribution**, suggesting a small number of very large communities dominate
- The `total_social_presence` metric shows extreme skew — *Pulse Nation* leads at **123,596**

---

## ⚠️ Known Gaps

- **Satellite table coverage:** `COMMUNITY_STAFF`, `COMMUNITY_SOCIAL_MEDIA`, and `COMMUNITY_GAME` are fully populated for community IDs **1–200** only. IDs **201–357** have core rows only. This is a documented scope limitation.
- **Derived EDA columns** (`engagement_ratio`, `tier_score`, etc.) are intentionally excluded from the physical schema — they are computed at query time to preserve 3NF compliance.
- `year_founded` anomalies (future years) were replaced with `NaN` rather than imputed, resulting in some null values in the cleaned dataset.

---

## 👤 Author

<div align="center">

### Faizan Toheed

*Sole Participant & Project Author*

[![GitHub](https://img.shields.io/badge/GitHub-FaizanToheed-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/FaizanToheed)

</div>

This project was independently designed, built, and documented in its entirety by **Faizan Toheed** — from raw CSV ingestion through exploratory data analysis, entity-relationship modelling, 3NF normalisation theory, full MySQL implementation, and final reporting.

| Role | Responsibility |
|------|---------------|
| **Data Analyst** | EDA across 4 Jupyter sessions; cleaning, feature engineering, visualisation |
| **Database Designer** | Entity identification, ER modelling (Crow's Foot notation), 3NF normalisation |
| **SQL Developer** | 5 SQL script files, 16 tables, 3 views, 12 analytical queries, 22 indexes |
| **Report Author** | Full written documentation across all project phases |

---

<div align="center">

*Built with ❤️ by Faizan Toheed*

</div>
