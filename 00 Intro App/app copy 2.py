import streamlit as st
import pandas as pd
import altair as alt
from langchain_google_genai import ChatGoogleGenerativeAI
from langchain_core.messages import HumanMessage, SystemMessage

# ------------- Dataset Preparation -------------

songs_df = pd.DataFrame({
    'Song': ['Blinding Lights', 'Hello', 'Shape of You', 'Believer', 'Bad Guy', 'Senorita', 'Levitating', 'Stay', 'Peaches', 'Savage Love'],
    'Artist': ['The Weeknd', 'Adele', 'Ed Sheeran', 'Imagine Dragons', 'Billie Eilish', 'Shawn Mendes', 'Dua Lipa', 'Justin Bieber', 'Justin Bieber', 'Jason Derulo'],
    'Release_Year': [2020, 2015, 2017, 2017, 2019, 2019, 2021, 2021, 2021, 2020],
    'Genre': ['Pop', 'Soul', 'Pop', 'Rock', 'Pop', 'Pop', 'Pop', 'Pop', 'R&B', 'Pop']
})

students_df = pd.DataFrame({
    'Name': ['Riya', 'Aman', 'Zara', 'Ishaan', 'Neha', 'Arjun', 'Sara', 'Dev', 'Kiran', 'Tara'],
    'Roll No': [101, 102, 103, 104, 105, 106, 107, 108, 109, 110],
    'Branch': ['CSE', 'ECE', 'CSE', 'ME', 'CSE', 'ECE', 'CSE', 'ME', 'EEE', 'CSE'],
    'Year': [2, 3, 2, 1, 4, 3, 2, 1, 4, 3],
    'CGPA': [8.2, 7.5, 9.0, 7.8, 8.5, 6.9, 9.1, 7.6, 8.0, 8.9]
})

orders_df = pd.DataFrame({
    'OrderID': range(1001, 1011),
    'Customer': ['Alice', 'Bob', 'Charlie', 'Diana', 'Eve', 'Frank', 'Grace', 'Heidi', 'Ivan', 'Judy'],
    'Product': ['Phone', 'Laptop', 'Tablet', 'Phone', 'Laptop', 'Tablet', 'Phone', 'Laptop', 'Tablet', 'Phone'],
    'Quantity': [1, 1, 2, 1, 3, 1, 2, 1, 2, 1],
    'Date': pd.date_range(start='2023-06-01', periods=10, freq='D')
})

books_df = pd.DataFrame({
    'Title': ['Book A', 'Book B', 'Book C', 'Book D', 'Book E', 'Book F', 'Book G', 'Book H', 'Book I', 'Book J'],
    'Author': ['Author 1', 'Author 2', 'Author 1', 'Author 3', 'Author 2', 'Author 4', 'Author 1', 'Author 3', 'Author 5', 'Author 4'],
    'Genre': ['Fiction', 'Non-Fiction', 'Fiction', 'Sci-Fi', 'Non-Fiction', 'Romance', 'Fiction', 'Sci-Fi', 'Romance', 'Fiction'],
    'Rating': [4.2, 3.8, 4.5, 4.0, 3.9, 4.1, 4.7, 4.3, 3.6, 4.4]
})

stocks_df = pd.DataFrame({
    'Date': pd.date_range(start='2024-01-01', periods=10),
    'Company': ['AAPL', 'GOOGL', 'MSFT', 'AAPL', 'GOOGL', 'MSFT', 'AAPL', 'GOOGL', 'MSFT', 'AAPL'],
    'Price': [150, 2800, 310, 152, 2850, 312, 149, 2820, 308, 153],
    'Volume': [10000, 8000, 9000, 11000, 8500, 9200, 9800, 8300, 9100, 10500]
})

datasets = {
    'Songs': songs_df,
    'Students': students_df,
    'Orders': orders_df,
    'Books': books_df,
    'Stocks': stocks_df
}

default_questions = {
    'Songs': {
        'How many Pop songs are there?': lambda df: df[df['Genre'] == 'Pop'].shape[0],
        'List all songs by Justin Bieber': lambda df: df[df['Artist'] == 'Justin Bieber']
    },
    'Students': {
        'Average CGPA of CSE students?': lambda df: df[df['Branch'] == 'CSE']['CGPA'].mean(),
        'List 3rd year students': lambda df: df[df['Year'] == 3]
    },
    'Orders': {
        'Total quantity of Phones ordered?': lambda df: df[df['Product'] == 'Phone']['Quantity'].sum(),
        'Orders placed after 2023-06-05': lambda df: df[df['Date'] > '2023-06-05']
    },
    'Books': {
        'Average rating of Fiction books?': lambda df: df[df['Genre'] == 'Fiction']['Rating'].mean(),
        'Books by Author 1': lambda df: df[df['Author'] == 'Author 1']
    },
    'Stocks': {
        'Average price of AAPL': lambda df: df[df['Company'] == 'AAPL']['Price'].mean(),
        'Stock data after 2024-01-05': lambda df: df[df['Date'] > '2024-01-05']
    }
}

# ------------- Utility Functions -------------

def extract_schema(df):
    return "\n".join(f"{col}: {dtype}" for col, dtype in df.dtypes.items())

def execute_pandas_code(code: str, df: pd.DataFrame):
    try:
        result = eval(code, {"df": df})
        if isinstance(result, pd.DataFrame):
            st.dataframe(result)
        elif isinstance(result, (pd.Series, list, tuple)):
            st.write(result)
        else:
            st.write(f"🔢 Result: `{result}`")
    except Exception as e:
        st.error(f"❌ Error: {e}")

# ------------- Gemini Model Setup -------------
llm = ChatGoogleGenerativeAI(model="gemini-1.5-flash", temperature=0)

# ------------- Streamlit UI -------------

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

        if dataset_name == 'Songs':
            st.markdown("#### 🎵 Songs by Genre (Pie Chart)")
            genre_counts = df['Genre'].value_counts().reset_index()
            genre_counts.columns = ['Genre', 'Count']
            chart = alt.Chart(genre_counts).mark_arc(innerRadius=50).encode(
                theta='Count:Q',
                color='Genre:N',
                tooltip=['Genre', 'Count']
            ).properties(title='Distribution of Songs by Genre')
            st.altair_chart(chart, use_container_width=True)

        elif dataset_name == 'Students':
            st.markdown("#### 🎓 Average CGPA by Branch (Bar Chart)")
            chart = alt.Chart(df).mark_bar().encode(
                x='Branch',
                y='average(CGPA)',
                color='Branch'
            ).properties(title='Average CGPA per Branch')
            st.altair_chart(chart, use_container_width=True)

            st.markdown("#### 🎓 Count of Students per Year (Pie Chart)")
            year_counts = df['Year'].value_counts().reset_index()
            year_counts.columns = ['Year', 'Count']
            chart2 = alt.Chart(year_counts).mark_arc(innerRadius=40).encode(
                theta='Count:Q',
                color='Year:N',
                tooltip=['Year', 'Count']
            ).properties(title='Students per Year')
            st.altair_chart(chart2, use_container_width=True)

        elif dataset_name == 'Orders':
            st.markdown("#### 📦 Orders Over Time by Product (Line Chart)")
            chart = alt.Chart(df).mark_line(point=True).encode(
                x='Date:T',
                y='sum(Quantity)',
                color='Product',
                tooltip=['Date', 'Quantity', 'Product']
            ).properties(title='Quantity Ordered Over Time')
            st.altair_chart(chart, use_container_width=True)

            st.markdown("#### 📊 Product Quantity Distribution (Bar Chart)")
            prod_summary = df.groupby('Product')['Quantity'].sum().reset_index()
            chart2 = alt.Chart(prod_summary).mark_bar().encode(
                x='Product',
                y='Quantity',
                color='Product'
            ).properties(title='Total Quantity Ordered per Product')
            st.altair_chart(chart2, use_container_width=True)

        elif dataset_name == 'Books':
            st.markdown("#### 📚 Average Rating by Genre (Bar Chart)")
            chart = alt.Chart(df).mark_bar().encode(
                x='Genre',
                y='average(Rating)',
                color='Genre'
            ).properties(title='Average Rating per Genre')
            st.altair_chart(chart, use_container_width=True)

            st.markdown("#### 📘 Books per Author (Pie Chart)")
            author_counts = df['Author'].value_counts().reset_index()
            author_counts.columns = ['Author', 'Count']
            chart2 = alt.Chart(author_counts).mark_arc(innerRadius=40).encode(
                theta='Count:Q',
                color='Author:N',
                tooltip=['Author', 'Count']
            ).properties(title='Books per Author')
            st.altair_chart(chart2, use_container_width=True)

        elif dataset_name == 'Stocks':
            st.markdown("#### 📈 Stock Prices Over Time (Line Chart)")
            chart = alt.Chart(df).mark_line(point=True).encode(
                x='Date:T',
                y='Price',
                color='Company',
                tooltip=['Date', 'Price', 'Company']
            ).properties(title='Stock Price Trends')
            st.altair_chart(chart, use_container_width=True)

            st.markdown("#### 📉 Volume Distribution per Company (Bar Chart)")
            volume_summary = df.groupby('Company')['Volume'].mean().reset_index()
            chart2 = alt.Chart(volume_summary).mark_bar().encode(
                x='Company',
                y='Volume',
                color='Company'
            ).properties(title='Average Volume per Company')
            st.altair_chart(chart2, use_container_width=True)


elif section == "Part 2: OLAP/OLTP":
    st.title("🏢 OLTP vs OLAP and Data Warehousing")
    st.write("This diagram helps you understand how companies move data from operational systems to analytical systems.")
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
