import sqlite3

# create a database file
conn=sqlite3.connect('data/curious.db')

c = conn.cursor()

# drop a table
c.execute('''DROP TABLE temperatures''')

# Create a table
c.execute('''
   CREATE TABLE temperatures (
      id      INTEGER PRIMARY KEY,
      city    TEXT,
      date    DATE,
      temp    INTEGER)'''
)
conn.commit()