import sqlite3

conn=sqlite3.connect('data/curious.db')
c = conn.cursor()

sql='''
    SELECT *
    FROM temperatures
'''

cursor = c.execute(sql)

col_names = [description[0] for description in cursor.description]
print(col_names)  
#next(zip(*cursor.description))

conn.commit()