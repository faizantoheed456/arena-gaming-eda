import streamlit as st
import pandas as pd
import joblib
import os

# Setup Page
st.set_page_config(page_title="ARENA Predictor", page_icon="🎮", layout="wide")

# Load model
model_path = 'ML and EDA/model.joblib'
if not os.path.exists(model_path):
    st.error(f"Model file not found at {model_path}. Please train the model first.")
    st.stop()

@st.cache_resource
def load_model():
    return joblib.load(model_path)

model = load_model()

# UI
st.title("🎮 ARENA Community Tier Predictor")
st.markdown("Enter your community metrics to predict your Tier.")
st.divider()

# Columns for layout
col1, col2 = st.columns(2)

input_data = {}
with col1:
    st.subheader("👥 Structure & Growth")
    input_data['member_count'] = st.slider("Member Count", 0, 15000, 500)
    input_data['active_players'] = st.slider("Active Players", 0, 8000, 200)
    # Increased max from 100 to 1000
    input_data['tournaments_hosted'] = st.number_input("Tournaments Hosted", 0, 1000, 5)

with col2:
    st.subheader("🌐 Social & Engagement")
    input_data['discord_server_size'] = st.slider("Discord Server Size", 0, 10000, 500)
    input_data['reddit_community_size'] = st.slider("Reddit Community Size", 0, 10000, 500)
    input_data['engagement_ratio'] = st.slider("Engagement Ratio", 0.0, 1.0, 0.5, 0.01)
    input_data['tournament_intensity'] = st.number_input("Tournament Intensity", 0.0, 200.0, 10.0)

st.divider()

# Predict
if st.button("🚀 Predict Tier"):
    input_df = pd.DataFrame([input_data])
    
    # 1. Hard Override Rule for Elite Tier
    is_elite = (
        input_data['member_count'] > 9000 and 
        input_data['active_players'] > 4500 and 
        input_data['tournaments_hosted'] > 500
    )
    
    if is_elite:
        prediction = ["Elite"]
        st.info("💡 High-performance metrics detected: Hard-coded override applied.")
        st.snow() # Added animation for high-tier
    else:
        prediction = model.predict(input_df)
        
        # 2. Debugging Probabilities
        probs = model.predict_proba(input_df)
        classes = model.classes_
        st.write("---")
        st.write("### Model Confidence (Debugging):")
        prob_df = pd.DataFrame(probs, columns=classes)
        st.table(prob_df)
        print(f"Probabilities: {dict(zip(classes, probs[0]))}") # To terminal
    
    st.balloons()
    st.success(f"### Predicted Tier: **{prediction[0]}**")
