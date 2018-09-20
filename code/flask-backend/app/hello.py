from flask import Flask, __version__

from pymongo import MongoClient
import json

app = Flask(__name__)

client = MongoClient("db", 27017)


@app.route("/api/hello")
def hello():
    return json.dumps(
        client['test']['welcome'].find_one()['welcome_text']
    )


@app.route("/api/version")
def version():
    return json.dumps(
        __version__
    )
