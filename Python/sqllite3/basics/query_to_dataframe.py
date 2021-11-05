import sqlite3
from pandas import DataFrame

conn=sqlite3.connect('data/curious.db')
c = conn.cursor()

sql='''
    SELECT *
    FROM temperatures
'''

c.execute(sql)
#print(c.fetchall())  

df = DataFrame(c.fetchall()
                #, columns=['Client_Name'
                #,'Country_Name'
                # ,'Date']
                )
print(df)
#conn.commit()