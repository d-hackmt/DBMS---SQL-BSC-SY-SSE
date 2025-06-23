import streamlit as st
import pandas as pd

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
