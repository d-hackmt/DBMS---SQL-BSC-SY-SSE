import streamlit as st
from langchain_google_genai import ChatGoogleGenerativeAI
from langchain_core.messages import HumanMessage, SystemMessage

from data import datasets, default_questions
from utils import extract_schema, execute_pandas_code

import altair as alt

import warnings
warnings.filterwarnings("ignore", category=UserWarning, module="langchain")

# Gemini Setup
llm = ChatGoogleGenerativeAI(model="gemini-1.5-flash", temperature=0)

st.sidebar.title("📚 DBMS Intro Lecture")
section = st.sidebar.radio("Go to", ["Part 1: Interactive", "Part 2: OLAP/OLTP", "Part 3: Tech Overview"])

if section == "Part 1: Interactive":
    st.title("💡 Understand Data Like a Human")
    dataset_name = st.selectbox("Select a dataset", list(datasets.keys()))
    df = datasets[dataset_name]

    st.subheader(f"📋 Here's the '{dataset_name}' dataset:")
    st.dataframe(df, use_container_width=True)

    tab1, tab2 = st.tabs(["🤔 Ask Me", "📊 Look At Me"])

    with tab1:
        st.subheader("Some questions you might ask:")
        for question, logic in default_questions[dataset_name].items():
            if st.button(question):
                result = logic(df)
                st.write(result)

        st.markdown("---")
        st.subheader("💬 Ask a question in plain English")
        user_input = st.text_input("Example: Show all Fiction books after rating 4")

        if user_input:
            with st.spinner("Gemini is thinking..."):
                schema = extract_schema(df)
                system_prompt = f"""
You are a pandas expert. A DataFrame named `df` is available.

Schema:
{schema}

Write a one-line pandas code to answer the user's question. 
Use case-insensitive matching for strings.

Example: 
df[df['Column'].str.lower() == 'value']

Return ONLY the pandas code. No explanation.
"""

                response = llm.invoke([
                    SystemMessage(content=system_prompt),
                    HumanMessage(content=user_input)
                ])

                code = response.content.strip()
                st.code(code, language="python")
                execute_pandas_code(code, df)

    with tab2:
        st.subheader("Visual Exploration")

        # Add your conditional visual logic here (as written earlier)
        # Example:
        if dataset_name == 'Songs':
            genre_counts = df['Genre'].value_counts().reset_index()
            genre_counts.columns = ['Genre', 'Count']
            chart = alt.Chart(genre_counts).mark_arc(innerRadius=50).encode(
                theta='Count:Q', color='Genre:N', tooltip=['Genre', 'Count']
            ).properties(title='Distribution of Songs by Genre')
            st.altair_chart(chart, use_container_width=True)

        # Add other dataset visuals similarly...

elif section == "Part 2: OLAP/OLTP":
    st.title("🏢 OLTP vs OLAP and Data Warehousing")
    st.image("img.png", caption="Data Flow from OLTP to OLAP")

elif section == "Part 3: Tech Overview":
    st.title("🛠️ Technologies in Data Handling")
    tab1, tab2 = st.tabs(["Databases", "Visualization Tools"])
    with tab1:
        st.markdown("### Structured Data (Relational DBMS):")
        st.write("- MySQL\n- PostgreSQL\n- Oracle\n- SQL Server")
        st.markdown("### Unstructured Data (NoSQL DBMS):")
        st.write("- MongoDB\n- Cassandra\n- Firebase")
    with tab2:
        st.markdown("### Data Visualization Tools:")
        st.write("- Power BI\n- Tableau\n- Python (matplotlib, seaborn, plotly)\n- MATLAB")
