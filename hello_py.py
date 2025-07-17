from flask import Flask
import json

load_dotenv()

app = Flask(__name__)

@app.route("/")
def Hello_py():
    
    mensagem = "Hello, meu app Flask Python!" 

    return (mensagem)
