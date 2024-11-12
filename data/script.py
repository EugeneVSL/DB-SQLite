# import sqlite module , os
import sqlite3
from sqlite3 import OperationalError
import os

def createDB(db_path: str):

    # create database
    con = sqlite3.connect(db_path)

    return con 

def createDBEntities(con, ddl_file: str):

    # get the cursor
    cursor = con.cursor()

    # get the DDL instructions
    fd = open(ddl_file, 'r')
    file = fd.read()
    fd.close()

    # split them into an array
    sqlCommands = file.split(';')

    for command in sqlCommands:

        try:
            # execute the current DDL command
            cursor.execute(command)
        except OperationalError as err: 
            print(f"Operation failed: {err}")

# define the database path
db_file_path = 'data/customer.db'

# define the DDL file path
ddl_script_path = 'data/sql_scripts/create.sql'

if os.path.exists(db_file_path):

    try:
        os.remove(db_file_path)
        print(f"File '{db_file_path}' deleted succesfully.")
    except FileNotFoundError: print(f"File '{db_file_path}' not found.")


# create the database
con = createDB(db_file_path)

# run DDL instructions
createDBEntities(con, ddl_script_path)

# close the connection
con.close()