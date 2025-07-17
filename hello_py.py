from importlib.metadata import version as get_version

__version__ = get_version(__package__)

from flask import Flask
import json

app = Flask(__name__)

@app.route("/")
def Hello_py():
    
    mensagem = "Hello, meu app Flask Python!" 

    return (mensagem)
