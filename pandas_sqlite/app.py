import pandas as pd
from sqlalchemy import create_engine
from sys import argv
from os import system

def main():
    #Read in a file path
    data_file = argv[1]

    #Welcome Screen
    system('cls')

    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print('~   FILE TO PROCESS AND LOAD INTO SQLITE3:     ~')
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print_to_console(data_file)
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
 
    # Load a data file into a DataFrame
    print_to_console('.. Loading a data file into a DataFrame')
    df = pd.read_csv(data_file,delimiter='\t')

    # Define a SQLite engine 
    print_to_console('.. Defining a SQLite engine')
    engine = create_engine('sqlite:///pandas_sqlite.db', echo=False)
    sqlite_connection = engine.connect()

    # Load the DataFrame into SQLite
    print_to_console('.. Loading the DataFrame into SQLite')ipython
    sqlite_table = "prototype_sample"
    df.to_sql(sqlite_table, sqlite_connection, if_exists='fail')

    # Close connection to sqlite
    # print_to_console('.. Closing connection to sqlite')
    # sqlite_connection.close()

    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print('~  Load Completed. Exiting...')
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print('')

def print_to_console(a_text):
    print('~')
    print('~ ', a_text)

if __name__ == "__main__":
    main()