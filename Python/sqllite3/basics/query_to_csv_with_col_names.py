import sqlite3
from pandas import DataFrame

conn=sqlite3.connect('data/curious.db')
c = conn.cursor()

sql='''
    SELECT id, city,date,temp
    FROM temperatures
'''

cursor = c.execute(sql)
col_names = [description[0] for description in cursor.description]

df = DataFrame(c.fetchall()
                , columns=col_names
                )
print(df)

df.to_csv('data/sql_output.csv', index=None, header=True)
#conn.commit()