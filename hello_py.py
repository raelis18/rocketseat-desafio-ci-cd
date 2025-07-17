__version__ = 'v1.0.0'

from flask import Flask
import json

app = Flask(__name__)

@app.route("/")
def Hello_py():
    
    mensagem = "Hello, meu app Flask Python!" 

    return (mensagem)
