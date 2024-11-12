# import sqlite module , os
import sqlite3
from sqlite3 import OperationalError
import os

def createDB(db_path: str):
    """_summary_

    Args:
        db_path (str): _description_

    Returns:
        _type_: _description_
    """
    # create database
    con = sqlite3.connect(db_path)

    return con 

def createDBEntities(con, ddl_file: str):
    """_summary_

    Args:
        con (_type_): _description_
        ddl_file (str): _description_
    """
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
    except FileNotFoundError as err: 
        print(f"File '{db_file_path}' not found. {err}")


# create the database
con = createDB(db_file_path)

# run DDL instructions
createDBEntities(con, ddl_script_path)

# close the connection
con.close()