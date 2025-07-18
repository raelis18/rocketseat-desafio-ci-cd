from flask import Flask
import json

app = Flask(__name__)

@app.route("/")
def hello_py():
    
    mensagem = "Hello, meu app Flask Python!" 

    return (mensagem)
