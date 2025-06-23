### Check it out : https://sqlintro.streamlit.app/

![image](https://github.com/user-attachments/assets/da28195f-b5b6-41ff-88c2-8e51bfcb5563)


## 📊 DBMS & SQL Interactive Streamlit App

This app is designed to help students learn the basics of **databases**, **SQL-style querying**, and **data visualization** interactively in a hands-on way.

---

### 🔧 Functionality Overview

#### 🧠 Part 1: Interactive Exploration
- Choose from multiple built-in datasets (Songs, Students, Orders, Books, Stocks).
- View and explore the dataset using two tabs:
  - ✅ **"Ask Me"** – Query the data:
    - Click pre-defined questions or
    - Ask in **plain English** using a built-in chatbot powered by **Google Gemini (via LangChain)**.
    - Schema is dynamically passed to the model to generate accurate Pandas queries.
  - 📊 **"Look At Me"** – Visualize the data:
    - Auto-generated charts based on dataset type:
      - Bar charts, Line charts, Pie charts, etc. using **Altair**.

---

#### 🏢 Part 2: OLTP vs OLAP
- Learn how data is generated and stored in real-world companies.
- Understand the difference between:
  - **OLTP (Online Transaction Processing)** – used in CRMs, ERPs, etc.
  - **OLAP (Online Analytical Processing)** – used in reporting, dashboards, etc.
- A clear diagram is provided to explain the **data warehousing pipeline**.

---

#### 🧰 Part 3: Tech Overview
- Overview of tools used in industry for handling and visualizing data:
  - **Databases**:
    - Structured: MySQL, PostgreSQL, Oracle, SQL Server
    - Unstructured: MongoDB, Cassandra, Firebase
  - **Visualization Tools**:
    - Power BI, Tableau, Python (matplotlib, seaborn, plotly), MATLAB
