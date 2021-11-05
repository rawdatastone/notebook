import sqlite3
import pandas as pd

conn=sqlite3.connect(r'data/curious.db')
c = conn.cursor()

read_temperatures=pd.read_csv('data/temperatures.csv')
read_temperatures.to_sql('temperatures',conn, if_exists='append', index = False)
