from flask import Flask
import mysql.connector
from mysql.connector import Error
from dotenv import load_dotenv
import os
import json

load_dotenv()

db_user = str(os.getenv("db_user"))
db_password = str(os.getenv("db_password"))
app = Flask(__name__)

@app.route("/")
def check_db():
    try:
        mydb = mysql.connector.connect(
            host="mysql",
            port=3306,
            user=db_user,
            password=db_password,
            database="app_flask"
        )
        mycursor = mydb.cursor()
        #mycursor.execute("show databases")
        mycursor.close()
        mydb.close()
        data = {
            "db_connection": "ESTABILISHED"
            }
        return json.dumps(data)
    except Error as e:
        data = {
            "db_connection": "FAILED",
            "error": str(e)
            }
        return json.dumps(data)
