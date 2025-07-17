__version__ = importlib.metadata.version(__name__)

from flask import Flask
import json

app = Flask(__name__)

@app.route("/")
def Hello_py():
    
    mensagem = "Hello, meu app Flask Python!" 

    return (mensagem)
