import streamlit as st
import pandas as pd
import numpy as np
import plotly.express as px
import plotly.graph_objects as go
import streamlit.components.v1 as components
import os

st.set_page_config(
    page_title="ARENA — Gaming Communities EDA",
    page_icon=None,
    layout="wide",
    initial_sidebar_state="collapsed"
)

# ─────────────────────────────────────────────
#  COLOR PALETTE
# ─────────────────────────────────────────────
CAT_COLORS = ["#1d4ed8","#0891b2","#059669","#d97706","#dc2626","#7c3aed","#db2777","#65a30d"]

# ─────────────────────────────────────────────
#  STYLESHEET (subtitle style only, titles handled in Plotly)
# ─────────────────────────────────────────────
st.markdown("""
<style>
@import url('https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=DM+Sans:ital,wght@0,300;0,400;0,500;0,600;1,400&display=swap');

/* Base */
html, body, .stApp, [data-testid="stAppViewContainer"], [data-testid="stMain"] {
    background: #f5f7ff !important;
    font-family: 'DM Sans', sans-serif !important;
    color: #0f172a !important;
}
[data-testid="stHeader"]          { display: none !important; }
[data-testid="stSidebar"]         { display: none !important; }
[data-testid="collapsedControl"]  { display: none !important; }
.block-container { padding: 0 48px 80px 48px !important; max-width: 1400px; margin: 0 auto; }

/* Top banner */
.top-banner {
    background: linear-gradient(120deg, #0f172a 0%, #1e3a8a 55%, #2563eb 100%);
    border-radius: 0 0 24px 24px;
    padding: 40px 52px 36px 52px;
    margin: 0 -48px 48px -48px;
    position: relative;
    overflow: hidden;
}
.top-banner::before {
    content: '';
    position: absolute; inset: 0;
    background: radial-gradient(ellipse at 80% 50%, rgba(59,130,246,0.25) 0%, transparent 60%);
}
.top-banner-inner { position: relative; z-index: 1; }
.top-banner h1 {
    font-family: 'Syne', sans-serif !important;
    font-size: 42px !important; font-weight: 800 !important;
    color: #ffffff !important; letter-spacing: -0.02em !important;
    margin: 0 0 10px 0 !important; line-height: 1 !important;
}
.top-banner .sub {
    font-size: 15px; color: #93c5fd; margin: 0;
    font-weight: 400; letter-spacing: 0.01em;
}
.top-banner .pill {
    display: inline-block;
    background: rgba(255,255,255,0.12);
    border: 1px solid rgba(255,255,255,0.2);
    color: #bfdbfe !important; font-size: 11px; font-weight: 600;
    letter-spacing: 0.08em; text-transform: uppercase;
    padding: 4px 14px; border-radius: 20px; margin-right: 8px; margin-top: 16px;
}

/* Section heading */
.section-heading {
    font-family: 'Syne', sans-serif;
    font-size: 24px; font-weight: 800;
    color: #1e3a8a;
    letter-spacing: -0.01em;
    margin: 56px 0 6px 0;
    padding-bottom: 12px;
    border-bottom: 2px solid #dbeafe;
}
.section-sub {
    font-size: 14px; color: #64748b;
    margin: 0 0 24px 0; font-weight: 400;
}

/* Chart block heading (title above plotly chart) */
.chart-heading {
    font-family: 'Syne', sans-serif !important;
    font-size: 16px !important;
    font-weight: 700 !important;
    color: #1d4ed8 !important;
    margin: 0 0 4px 0 !important;
    letter-spacing: -0.005em !important;
}
/* Subtitle — forced style with !important */
.chart-sub {
    font-family: 'DM Sans', sans-serif !important;
    font-size: 12px !important;
    font-weight: 400 !important;
    color: #94a3b8 !important;
    text-transform: uppercase !important;
    letter-spacing: 0.06em !important;
    margin: 0 0 14px 0 !important;
    line-height: 1.4 !important;
}

/* Table */
.tbl-wrap { border-radius: 12px; overflow-x: auto; overflow-y: hidden; border: 1px solid #dbeafe; }
table.arena { width: 100% !important; border-collapse: collapse !important; font-size: 13px !important; background: #fff !important; }
table.arena th {
    background: #1e3a8a !important; color: #fff !important;
    font-weight: 700 !important; font-size: 10px !important;
    text-transform: uppercase !important; letter-spacing: 0.08em !important;
    padding: 10px 14px !important; text-align: left !important;
}
table.arena td {
    padding: 9px 14px !important; color: #1e293b !important;
    border-bottom: 1px solid #f1f5f9 !important;
}
table.arena tr:nth-child(even) td { background: #f8faff !important; }
table.arena tr:hover td { background: #eff6ff !important; }

/* Insight card */
.insight {
    background: #fff;
    border: 1px solid #dbeafe;
    border-top: 3px solid #1d4ed8;
    border-radius: 0 0 12px 12px;
    padding: 18px 22px 16px 22px;
    margin-top: 0;
}
.insight-label {
    font-size: 9px; font-weight: 700;
    color: #1d4ed8; letter-spacing: 0.14em;
    text-transform: uppercase; margin-bottom: 10px;
}
.insight-row {
    display: flex; gap: 8px;
    margin-bottom: 8px; align-items: flex-start;
}
.insight-row:last-child { margin-bottom: 0; }
.ins-bar {
    width: 3px; min-height: 18px; border-radius: 2px;
    background: #2563eb; flex-shrink: 0; margin-top: 3px;
}
.ins-txt { font-size: 13px; color: #1e293b; line-height: 1.55; }
.ins-txt b { color: #1e3a8a; }

/* CSV viewer tabs */
[data-testid="stTabs"] [data-baseweb="tab-list"] {
    background: #fff !important; border-radius: 10px 10px 0 0 !important;
    padding: 6px 6px 0 6px !important; gap: 4px !important;
    border: 1px solid #dbeafe !important; border-bottom: none !important;
}
button[data-baseweb="tab"] {
    font-family: 'DM Sans', sans-serif !important;
    font-size: 12px !important; font-weight: 600 !important;
    color: #64748b !important; background: transparent !important;
    border: none !important; border-radius: 6px 6px 0 0 !important;
    padding: 8px 18px !important; letter-spacing: 0.01em !important;
}
button[data-baseweb="tab"][aria-selected="true"] {
    background: #1e3a8a !important; color: #fff !important;
}

/* Embedded chart wrapper */
.embed-wrap {
    background: #fff; border: 1px solid #dbeafe;
    border-radius: 12px; overflow: hidden;
    box-shadow: 0 2px 10px rgba(30,58,138,0.06);
}

/* Divider */
.chart-divider { height: 1px; background: #e2e8f0; margin: 48px 0; }

/* Scrollbar */
::-webkit-scrollbar { width: 5px; height: 5px; }
::-webkit-scrollbar-thumb { background: #93c5fd; border-radius: 10px; }
</style>
""", unsafe_allow_html=True)


# ─────────────────────────────────────────────
#  HELPERS
# ─────────────────────────────────────────────
def tbl(df):
    st.markdown(
        f'<div class="tbl-wrap">{df.to_html(classes="arena", border=0, justify="left")}</div>',
        unsafe_allow_html=True,
    )

def insight(*lines):
    rows = "".join(
        f'<div class="insight-row"><div class="ins-bar"></div><div class="ins-txt">{l}</div></div>'
        for l in lines
    )
    st.markdown(
        f'<div class="insight"><div class="insight-label">Insight</div>{rows}</div>',
        unsafe_allow_html=True,
    )

def chart_heading(title, subtitle=""):
    st.markdown(f'<div class="chart-heading">{title}</div>', unsafe_allow_html=True)
    if subtitle:
        st.markdown(f'<div class="chart-sub">{subtitle}</div>', unsafe_allow_html=True)

def section_heading(title, sub=""):
    st.markdown(f'<div class="section-heading">{title}</div>', unsafe_allow_html=True)
    if sub:
        st.markdown(f'<div class="section-sub">{sub}</div>', unsafe_allow_html=True)

def divider():
    st.markdown('<div class="chart-divider"></div>', unsafe_allow_html=True)

def base_layout(fig):
    """Apply simple black title style to all native Plotly charts."""
    fig.update_layout(
        paper_bgcolor="rgba(0,0,0,0)",
        plot_bgcolor="#ffffff",
        title=dict(
            font=dict(
                family="DM Sans, sans-serif",
                size=16,
                color="#000000",   # Simple black
                weight="normal"
            ),
            x=0.0,
            xanchor="left"
        ),
        font=dict(family="DM Sans, sans-serif", color="#1e293b"),
        legend=dict(
            bgcolor="rgba(255,255,255,0.95)",
            bordercolor="#dbeafe", borderwidth=1,
            font=dict(size=12, color="#0f172a"),
        ),
        margin=dict(t=50, b=50, l=10, r=10),
    )
    fig.update_xaxes(
        tickfont=dict(color="#475569", size=11),
        title_font=dict(family="DM Sans, sans-serif", size=13, color="#1e293b", weight="bold"),
        gridcolor="#f1f5f9",
        linecolor="#e2e8f0",
        zerolinecolor="#e2e8f0"
    )
    fig.update_yaxes(
        tickfont=dict(color="#475569", size=11),
        title_font=dict(family="DM Sans, sans-serif", size=13, color="#1e293b", weight="bold"),
        gridcolor="#f1f5f9",
        linecolor="#e2e8f0",
        zerolinecolor="#e2e8f0"
    )
    return fig

def embed_html(path, height=480):
    _script_dir  = os.path.dirname(os.path.abspath(__file__))
    _uploads_dir = "/mnt/user-data/uploads"
    _candidates  = [
        path,
        os.path.join(_script_dir,  os.path.basename(path)),
        os.path.join(_uploads_dir, os.path.basename(path)),
    ]
    _resolved = next((p for p in _candidates if os.path.isfile(p)), None)

    if _resolved:
        with open(_resolved, "r", encoding="utf-8") as f:
            html = f.read()
        # Force title text to black in embedded charts
        style_title_css = """
        <style>
            .g-title, .main-title, .title, text.pointtext, text.titletext,
            .plotly .main-svg text[class*="title"], .js-plotly-plot .main-svg text[class*="title"] {
                fill: #000000 !important;
                color: #000000 !important;
                font-family: 'DM Sans', sans-serif !important;
                font-weight: normal !important;
                font-size: 16px !important;
            }
        </style>
        """
        if "</head>" in html:
            html = html.replace("</head>", f"{style_title_css}</head>")
        else:
            html = style_title_css + html
        st.markdown('<div class="embed-wrap">', unsafe_allow_html=True)
        components.html(html, height=height, scrolling=False)
        st.markdown("</div>", unsafe_allow_html=True)
    else:
        st.markdown(
            f"""<div style="height:{height}px;border-radius:12px;border:1.5px dashed #93c5fd;
            background:#f0f6ff;display:flex;flex-direction:column;align-items:center;
            justify-content:center;gap:8px;">
            <span style="font-size:28px;">📂</span>
            <span style="font-size:13px;font-weight:600;color:#3b82f6;">Interactive chart file not found</span>
            <span style="font-size:11px;color:#94a3b8;font-family:monospace;">{os.path.basename(path)}</span>
            <span style="font-size:11px;color:#64748b;">Place the exported HTML next to this script to enable it.</span>
            </div>""",
            unsafe_allow_html=True,
        )


# ─────────────────────────────────────────────
#  DATA
# ─────────────────────────────────────────────
@st.cache_data
def load():
    raw      = pd.read_csv("gaming_communities.csv")
    cleaned  = pd.read_csv("gaming_communities_data_cleaned.csv")
    enhanced = pd.read_csv("gaming_communities_enhanced.csv")
    return raw, cleaned, enhanced

try:
    df_raw, df_clean, df_enh = load()
    data_ok = True
except Exception as e:
    st.error(f"Could not load data: {e}")
    data_ok = False


# ═════════════════════════════════════════════
#  TOP BANNER
# ═════════════════════════════════════════════
st.markdown("""
<div class="top-banner">
  <div class="top-banner-inner">
    <h1>ARENA — Gaming Communities EDA</h1>
    <p class="sub">Exploratory Data Analysis of 400+ gaming communities worldwide.<br>
       Patterns in growth, engagement, tournaments, and demographics across genres, tiers, regions, and platforms.</p>
    <span class="pill">357 Communities</span>
    <span class="pill">31+ Features</span>
    <span class="pill">Session 4 — Visualisation</span>
  </div>
</div>
""", unsafe_allow_html=True)


if not data_ok:
    st.stop()


# ═════════════════════════════════════════════
#  GLOBAL INSIGHTS SUMMARY
# ═════════════════════════════════════════════
section_heading(
    "Global Insights Summary",
    "High-level takeaways from the multi-session analysis."
)

kpi1, kpi2, kpi3, kpi4 = st.columns(4)

with kpi1:
    st.metric("Top Genre Engagement", "45.0%", "Battle Royale / MMORPG")
with kpi2:
    st.metric("Region Tier Leader", "1.63", "Asia (Avg Tier Score)")
with kpi3:
    st.metric("Dominant Language", "141", "English Communities")
with kpi4:
    st.metric("Tournament Leader", "525", "Semi-Pro Communities")

insight(
    "<b>Engagement Peak:</b> Battle Royale and MMORPG genres lead in active participation, maintaining nearly 45% player activity ratios.",
    "<b>Regional Maturity:</b> Asia exhibits the highest average maturity (Tier Score: 1.63), while South America shows more room for growth (1.37).",
    "<b>Competitive Hub:</b> Semi-Pro communities are the engine of competitive play, hosting over 500 tournaments collectively.",
    "<b>Oldest Community:</b> The dataset tracks communities dating back to 2008 (EU region), showing a 18-year legacy of persistence.",
)

divider()


# ═════════════════════════════════════════════
#  SECTION 1 — CSV VIEWER
# ═════════════════════════════════════════════
section_heading(
    "Dataset Explorer",
    "Click any tab to browse the raw, cleaned, or feature-engineered dataset."
)

tab_raw, tab_clean, tab_enh = st.tabs([
    "Raw Dataset  —  400 rows · 28 cols",
    "Cleaned Dataset  —  357 rows · 21 cols",
    "Enhanced Dataset  —  357 rows · 31+ cols",
])

with tab_raw:
    st.markdown(f"<p style='font-size:13px;color:#64748b;margin:12px 0 10px 0;'>{len(df_raw)} rows · {len(df_raw.columns)} columns — unprocessed, may contain missing values and mixed types.</p>", unsafe_allow_html=True)
    st.dataframe(df_raw, use_container_width=True, height=360)

with tab_clean:
    st.markdown(f"<p style='font-size:13px;color:#64748b;margin:12px 0 10px 0;'>{len(df_clean)} rows · {len(df_clean.columns)} columns — nulls imputed, outliers capped, types corrected.</p>", unsafe_allow_html=True)
    st.dataframe(df_clean, use_container_width=True, height=360)

with tab_enh:
    st.markdown(f"<p style='font-size:13px;color:#64748b;margin:12px 0 10px 0;'>{len(df_enh)} rows · {len(df_enh.columns)} columns — engineered fields added: engagement_ratio, log_member_count, community_age, total_social_presence, and more.</p>", unsafe_allow_html=True)
    st.dataframe(df_enh, use_container_width=True, height=360)


# ═════════════════════════════════════════════
#  SECTION 2 — CHARTS
# ═════════════════════════════════════════════
section_heading(
    "Charts",
    "Each chart is paired with its source aggregation table. Scroll to explore all analyses."
)


# ──────────────────────────────────────────────
#  CHART 1 — Community Tier Overview
# ──────────────────────────────────────────────
chart_heading("Members vs Active Players by Community Tier",
              "Logarithmic scale scatter — bubble size represents total social presence")

col_tbl, col_plt = st.columns([1, 2], gap="large")

with col_tbl:
    tier_df = df_enh.groupby("community_tier").agg(
        Avg_Members        = ("member_count",       "mean"),
        Avg_Active_Players = ("active_players",     "mean"),
        Total_Tournaments  = ("tournaments_hosted", "sum"),
    ).round(1)
    tbl(tier_df)

with col_plt:
    _scatter_df = df_enh.copy()
    if "total_social_presence" in _scatter_df.columns:
        _scatter_df["_bubble"] = _scatter_df["total_social_presence"].clip(lower=1)
        _size_col = "_bubble"
    else:
        _scatter_df["_bubble"] = 8
        _size_col = "_bubble"
    fig = px.scatter(
        _scatter_df, x="member_count", y="active_players", log_x=True, log_y=True,
        color="community_tier", size=_size_col, size_max=20,
        color_discrete_sequence=CAT_COLORS,
        title="Members vs Active Players by Community Tier",
        labels={"member_count":"Total Members (Log Scale)","active_players":"Active Players (Log Scale)","community_tier":"Community Tier"},
    )
    base_layout(fig)
    st.plotly_chart(fig, use_container_width=True)

try:
    tier_sorted     = tier_df.sort_values("Avg_Members", ascending=False)
    top_tier_name   = tier_sorted.index[0]
    bot_tier_name   = tier_sorted.index[-1]
    elite_avg       = int(tier_sorted["Avg_Members"].iloc[0])
    amateur_avg     = int(tier_sorted["Avg_Members"].iloc[-1])
    ratio           = round(elite_avg / max(amateur_avg, 1), 1)
    tour_tier       = tier_df["Total_Tournaments"].idxmax()
    semi_tours      = int(tier_df["Total_Tournaments"].max())
    insight(
        f"<b>Scale Gap:</b> <b>{top_tier_name}</b> communities average <b>{elite_avg:,} members</b> — <b>{ratio}x larger</b> than <b>{bot_tier_name}</b> clusters (avg {amateur_avg:,}). The gap is visible on the log scale as a clear rightward cluster shift.",
        f"<b>Tournament Volume:</b> <b>{tour_tier}</b> groups drive the most tournament activity at <b>{semi_tours:,} total events</b> — indicating that competitive infrastructure peaks in this tier.",
    )
except Exception:
    pass

divider()


# ──────────────────────────────────────────────
#  CHART 2 — Tournament Intensity Box (embedded)
# ──────────────────────────────────────────────
chart_heading("Tournament Intensity by Tier",
              "Box plot — distribution of tournaments hosted per community")

col_tbl, col_plt = st.columns([1, 2], gap="large")

with col_tbl:
    box_df = df_enh.groupby("community_tier")["tournaments_hosted"].agg(
        Median  = "median",
        Mean    = "mean",
        Max     = "max",
        Std_Dev = "std",
    ).round(1)
    tbl(box_df)

with col_plt:
    embed_html("box_tournament_intensity_by_tier.html", height=400)

insight(
    f"<b>Spread:</b> The standard deviation tells us that tournament counts are far more variable in Elite and Pro tiers — some communities host very few events while others host dozens.",
    f"<b>Outliers:</b> The box plot reveals heavy right skew in Semi-Pro and Pro tiers, meaning a small number of hyper-active communities pull the mean well above the median.",
)

divider()


# ──────────────────────────────────────────────
#  CHART 3 — Regional Engagement Bar
# ──────────────────────────────────────────────
chart_heading("Mean Engagement Index by Region",
              "Bar chart — average active-player-to-member ratio across global regions")

col_tbl, col_plt = st.columns([1, 2], gap="large")

with col_tbl:
    region_df = df_enh.groupby("region")["engagement_ratio"].agg(
        Mean_Engagement = "mean",
        Peak_Ratio      = "max",
        Std_Dev         = "std",
    ).round(3)
    tbl(region_df)

with col_plt:
    r_bar = df_enh.groupby("region", as_index=False)["engagement_ratio"].mean().sort_values("engagement_ratio", ascending=False)
    fig2 = px.bar(
        r_bar, x="region", y="engagement_ratio",
        color="engagement_ratio", color_continuous_scale="Blues",
        title="Mean Engagement Index by Region",
        labels={"engagement_ratio":"Mean Engagement Ratio","region":"Global Region"},
    )
    base_layout(fig2)
    fig2.update_layout(coloraxis_showscale=False)
    fig2.update_traces(marker_line_width=0)
    st.plotly_chart(fig2, use_container_width=True)

top_r = region_df["Mean_Engagement"].idxmax()
low_r = region_df["Mean_Engagement"].idxmin()
top_v = region_df["Mean_Engagement"].max()
low_v = region_df["Mean_Engagement"].min()
insight(
    f"<b>Top Market:</b> <b>{top_r}</b> leads all regions with a mean engagement index of <b>{top_v:.3f}</b>, indicating that a higher proportion of members are actively playing — not just registered.",
    f"<b>Weakest Region:</b> <b>{low_r}</b> trails at <b>{low_v:.3f}</b>. The gap between top and bottom is <b>{round(top_v-low_v,3)}</b> — meaningful enough to suggest structural differences in community culture or platform habits.",
)

divider()


# ──────────────────────────────────────────────
#  CHART 4 — Region Engagement (embedded)
# ──────────────────────────────────────────────
chart_heading("Region Engagement — Detailed Interactive View",
              "Embedded Plotly chart from EDA session 4")

col_tbl, col_plt = st.columns([1, 2], gap="large")

with col_tbl:
    if "has_coaching" in df_enh.columns:
        _coaching_series = df_enh["has_coaching"]
        if _coaching_series.dtype == bool or _coaching_series.dtype == object:
            df_enh["_coaching_num"] = _coaching_series.map(
                lambda x: 1 if str(x).strip().lower() in ("true","1","yes") else 0
            )
        else:
            df_enh["_coaching_num"] = pd.to_numeric(_coaching_series, errors="coerce").fillna(0)
        reg_detail = df_enh.groupby("region").agg(
            Communities      = ("community_name",  "count"),
            Avg_Members      = ("member_count",    "mean"),
            Avg_Engagement   = ("engagement_ratio","mean"),
            Coaching_Rate    = ("_coaching_num",   "mean"),
        ).round(2)
    else:
        reg_detail = df_enh.groupby("region").agg(
            Communities      = ("community_name",  "count"),
            Avg_Members      = ("member_count",    "mean"),
            Avg_Engagement   = ("engagement_ratio","mean"),
        ).round(2)
        reg_detail["Coaching_Rate"] = float("nan")
    tbl(reg_detail)

with col_plt:
    embed_html("region_engagement_analysis.html", height=440)

coaching_top = reg_detail["Coaching_Rate"].dropna().idxmax() if reg_detail["Coaching_Rate"].notna().any() else "N/A"
coaching_val = round(reg_detail["Coaching_Rate"].max() * 100, 1) if reg_detail["Coaching_Rate"].notna().any() else 0.0
insight(
    f"<b>Coaching Availability:</b> <b>{coaching_top}</b> has the highest coaching adoption at <b>{coaching_val}%</b> of communities — suggesting a more structured, growth-oriented community culture.",
    f"<b>Community Density:</b> Member counts vary significantly by region. Communities in high-density regions tend to have lower engagement ratios — consistent with the idea that larger communities dilute active participation rates.",
)

divider()


# ──────────────────────────────────────────────
#  CHART 5 — Top 15 Countries
# ──────────────────────────────────────────────
chart_heading("Top 15 Countries by Total Members",
              "Bar chart — aggregated member count per country")

col_tbl, col_plt = st.columns([1, 2], gap="large")

with col_tbl:
    if "country_of_origin" in df_enh.columns:
        country_df = df_enh.groupby("country_of_origin")["member_count"].agg(
            Total_Members  = "sum",
            Communities    = "count",
            Avg_Per_Comm   = "mean",
        ).round(0).nlargest(15, "Total_Members")
        tbl(country_df)
    else:
        st.info("Country column not found in enhanced dataset.")
        country_df = pd.DataFrame()

with col_plt:
    if not country_df.empty:
        fig5 = px.bar(
            country_df.reset_index(), x="country_of_origin", y="Total_Members",
            color="Total_Members", color_continuous_scale="Viridis",
            title="Top 15 Countries by Total Members",
            labels={"Total_Members":"Total Member Count","country_of_origin":"Country of Origin"},
        )
        base_layout(fig5)
        fig5.update_layout(coloraxis_showscale=False)
        st.plotly_chart(fig5, use_container_width=True)
    else:
        st.info("Country data unavailable.")

if not country_df.empty:
    top_country = country_df["Total_Members"].idxmax()
    top_count   = int(country_df["Total_Members"].max())
    top_comms   = int(country_df.loc[top_country, "Communities"])
    insight(
        f"<b>Dominant Nation:</b> <b>{top_country}</b> accounts for <b>{top_count:,} total members</b> across <b>{top_comms} communities</b> — the single largest national concentration in the dataset.",
        f"<b>Long Tail:</b> The top 15 countries represent a disproportionate share of total membership. Countries ranked 10-15 have significantly fewer members, pointing to a highly skewed global distribution.",
    )

divider()


# ──────────────────────────────────────────────
#  CHART 6 — Top 15 Countries detailed (embedded)
# ──────────────────────────────────────────────
chart_heading("Top 15 Countries — Expanded Member View",
              "Interactive breakdown with additional community-level context")

col_tbl, col_plt = st.columns([1, 2], gap="large")

with col_tbl:
    if not country_df.empty:
        tbl(country_df)
    else:
        st.info("Country data unavailable.")

with col_plt:
    embed_html("top_15_countries_members.html", height=440)

insight(
    "<b>Average Community Size:</b> Countries with fewer communities but high total membership tend to have fewer but much larger individual communities — a concentration effect rather than breadth.",
    "<b>Strategic Relevance:</b> Focusing acquisition efforts on top-5 countries would likely yield the highest return given the existing community density and member base.",
)

divider()


# ──────────────────────────────────────────────
#  CHART 7 — Genre Volume + Cumulative Growth
# ──────────────────────────────────────────────
chart_heading("Genre Member Volume & Cumulative Growth",
              "Total members by genre and historical growth trace for the top 3")

col_tbl, col_plt = st.columns([1, 2], gap="large")

with col_tbl:
    genre_df = df_enh.groupby("genre")["member_count"].agg(
        Total_Members  = "sum",
        Largest_Single = "max",
        Communities    = "count",
    ).sort_values("Total_Members", ascending=False)
    tbl(genre_df)

with col_plt:
    top3 = genre_df.index[:3].tolist()
    filt = df_enh[df_enh["genre"].isin(top3)].copy().sort_values("year_founded")
    filt["cumulative_members"] = filt.groupby("genre")["member_count"].cumsum()
    fig3 = px.line(
        filt, x="year_founded", y="cumulative_members",
        color="genre", markers=True,
        color_discrete_sequence=CAT_COLORS[:3],
        title="Genre Member Volume & Cumulative Growth",
        labels={"year_founded":"Year Founded","cumulative_members":"Cumulative Total Members","genre":"Game Genre"},
    )
    base_layout(fig3)
    st.plotly_chart(fig3, use_container_width=True)

top_g  = genre_df.index[0]
top_gs = int(genre_df["Total_Members"].iloc[0])
top_g2 = genre_df.index[1]
insight(
    f"<b>Dominant Genre:</b> <b>{top_g}</b> is the clear volume leader with <b>{top_gs:,} total members</b>. Its cumulative growth curve separates visibly from competitors after 2016.",
    f"<b>Second Place:</b> <b>{top_g2}</b> shows consistent growth but has not closed the gap — the divergence suggests {top_g} has benefited from network effects that are hard to replicate.",
)

divider()


# ──────────────────────────────────────────────
#  CHART 8 — Cumulative Growth (embedded)
# ──────────────────────────────────────────────
chart_heading("Cumulative Genre Growth — Interactive View",
              "Embedded chart with hover, zoom, and legend filtering")

col_tbl, col_plt = st.columns([1, 2], gap="large")

with col_tbl:
    growth_tbl = df_enh[df_enh["genre"].isin(top3)].groupby(["genre","year_founded"])["member_count"].sum().reset_index()
    growth_pivot = growth_tbl.pivot(index="year_founded", columns="genre", values="member_count").fillna(0).astype(int)
    tbl(growth_pivot)

with col_plt:
    embed_html("cumulative_growth_top3_genres.html", height=440)

insight(
    "<b>Inflection Points:</b> The interactive version makes it easy to spot years where growth accelerated sharply — likely tied to major game releases or platform expansions.",
    "<b>Post-2018 Surge:</b> All three top genres show steeper cumulative curves from 2018 onward, consistent with broader gaming industry growth during this period.",
)

divider()


# ──────────────────────────────────────────────
#  CHART 9 — Platform Histogram
# ──────────────────────────────────────────────
chart_heading("Log Member Count Distribution by Primary Platform",
              "Histogram — how community sizes are distributed across Discord, Reddit, Twitch, etc.")

col_tbl, col_plt = st.columns([1, 2], gap="large")

with col_tbl:
    plat_df = df_enh.groupby("primary_platform").agg(
        Communities    = ("community_name",    "count"),
        Avg_Log_Scale  = ("log_member_count",  "mean"),
        Avg_Members    = ("member_count",      "mean"),
    ).round(2).sort_values("Communities", ascending=False)
    tbl(plat_df)

with col_plt:
    fig4 = px.histogram(
        df_enh, x="log_member_count", color="primary_platform",
        nbins=22, opacity=0.88, barmode="group",
        color_discrete_sequence=CAT_COLORS,
        title="Log Member Count Distribution by Primary Platform",
        labels={"log_member_count":"Log Member Count (Log Scale)","primary_platform":"Primary Platform"},
    )
    base_layout(fig4)
    fig4.update_traces(marker_line_width=0.5, marker_line_color="white")
    st.plotly_chart(fig4, use_container_width=True)

top_p  = plat_df.index[0]
top_pc = int(plat_df["Communities"].iloc[0])
insight(
    f"<b>Platform Dominance:</b> <b>{top_p}</b> hosts <b>{top_pc} communities</b> — the largest share. Its distribution is wide, confirming it serves communities of all sizes from small niche groups to massive hubs.",
    f"<b>Size Differentiation:</b> Different platforms cluster at different points on the log scale. Communities on certain platforms (e.g. Twitch) tend to skew larger, suggesting the platform itself attracts or retains bigger audiences.",
)

divider()


# ──────────────────────────────────────────────
#  CHART 10 — Platform histogram (embedded)
# ──────────────────────────────────────────────
chart_heading("Platform Log Distribution — Interactive View",
              "Embedded interactive version with full Plotly controls")

col_tbl, col_plt = st.columns([1, 2], gap="large")

with col_tbl:
    tbl(plat_df)

with col_plt:
    embed_html("hist_log_member_count_by_platform.html", height=440)

insight(
    "<b>Bimodal Patterns:</b> Some platforms show two distinct peaks in the log distribution — one for casual communities and one for large established ones. This suggests the platform is used by two different types of organizers.",
    "<b>Niche Platforms:</b> Less common platforms have narrower distributions, indicating more homogeneous community sizes — likely because they attract a specific type of gaming community.",
)

divider()


# ──────────────────────────────────────────────
#  CHART 11 — Social Presence Scatter (embedded)
# ──────────────────────────────────────────────
chart_heading("Social Presence Analysis",
              "Scatter — Discord Followers vs Reddit Size, sized by content creators")

col_tbl, col_plt = st.columns([1, 2], gap="large")

with col_tbl:
    if all(c in df_enh.columns for c in ["discord_server_size","reddit_community_size","content_creators"]):
        social_tbl = df_enh.groupby("community_tier").agg(
            Avg_Discord  = ("discord_server_size",   "mean"),
            Avg_Reddit   = ("reddit_community_size", "mean"),
            Avg_Creators = ("content_creators",      "mean"),
            Total_Social = ("total_social_presence", "mean"),
        ).round(0)
        tbl(social_tbl)
    else:
        cols_avail = [c for c in ["discord_server_size","reddit_community_size","content_creators","total_social_presence"] if c in df_enh.columns]
        if cols_avail:
            tbl(df_enh.groupby("community_tier")[cols_avail].mean().round(0))

with col_plt:
    embed_html("scatter_social_presence.html", height=440)

insight(
    "<b>Social Amplification:</b> Communities with high Discord engagement tend to also have strong Reddit presence — the two channels reinforce each other rather than substituting.",
    "<b>Creator Effect:</b> Communities with more content creators show disproportionately large total social footprints. Content creation appears to be a multiplier for reach, not just a reflection of it.",
)

divider()


# ──────────────────────────────────────────────
#  CHART 12 — Sunburst (embedded)
# ──────────────────────────────────────────────
chart_heading("Region — Genre — Tier Hierarchy",
              "Sunburst chart — nested breakdown of how communities distribute across regions, genres, and tiers")

col_tbl, col_plt = st.columns([1, 2], gap="large")

with col_tbl:
    sun_tbl = df_enh.groupby(["region","genre","community_tier"]).agg(
        Count        = ("community_name", "count"),
        Avg_Members  = ("member_count",   "mean"),
    ).round(0)
    tbl(sun_tbl.head(20))
    st.caption("Showing first 20 combinations. Use the interactive chart to explore the full hierarchy.")

with col_plt:
    embed_html("sunburst_region_genre_tier.html", height=480)

insight(
    "<b>Regional Genre Preferences:</b> The sunburst reveals that genre popularity is not uniform across regions — certain genres dominate specific regional segments, pointing to cultural gaming preferences.",
    "<b>Tier Concentration:</b> Amateur communities are distributed across more genre-region combinations than Elite ones. Elite communities are more concentrated in a smaller set of genre-region pairings, suggesting that high-tier communities gravitate to specific ecosystems.",
)

divider()


# ──────────────────────────────────────────────
#  CHART 13 — 3D Scatter (embedded)
# ──────────────────────────────────────────────
chart_heading("3D Community Landscape",
              "Three-dimensional scatter — members, active players, and engagement ratio by tier")

col_tbl, col_plt = st.columns([1, 2], gap="large")

with col_tbl:
    d3_tbl = df_enh.groupby("community_tier").agg(
        Avg_Members    = ("member_count",      "mean"),
        Avg_Active     = ("active_players",    "mean"),
        Avg_Engagement = ("engagement_ratio",  "mean"),
        Count          = ("community_name",    "count"),
    ).round(2)
    tbl(d3_tbl)

with col_plt:
    embed_html("3d_scatter.html", height=520)

insight(
    "<b>Three-Dimensional Separation:</b> The 3D view confirms that tier clusters occupy genuinely distinct regions in the members-active-engagement space — they are not just linearly scaled versions of each other.",
    "<b>Engagement Inversion:</b> Interestingly, the highest-member communities do not always have the highest engagement ratios. The 3D scatter makes this inverse relationship visible in a way 2D charts cannot.",
)

