__version__ = "0.0.1"
from flask import Flask
import json

app = Flask(__name__)

@app.route("/")
def Hello_py():
    
    mensagem = "Hello, meu app Flask Python!" 

    return (mensagem)
