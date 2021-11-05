import sqlite3
from pandas import DataFrame

conn=sqlite3.connect('data/curious.db')
c = conn.cursor()

sql='''
    SELECT id, city,date,temp
    FROM temperatures
'''

c.execute(sql)
#print(c.fetchall())  

df = DataFrame(c.fetchall()
                # , columns=[
                #     'id'
                #     ,'city'
                #     ,'date'
                #     ,'temperature'
                #     ]
                )
print(df)
df.to_csv('data/sql_output.csv', index=None, header=True)
#conn.commit()