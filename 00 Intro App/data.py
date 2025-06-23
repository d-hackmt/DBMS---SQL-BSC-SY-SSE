import pandas as pd

# ----------- Dataset Preparation -----------

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
