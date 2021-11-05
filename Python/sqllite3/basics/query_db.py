import sqlite3

conn=sqlite3.connect('data/curious.db')
c = conn.cursor()

sql='''
    SELECT *
    FROM temperatures
'''

c.execute(sql)
print(c.fetchall())  

conn.commit()