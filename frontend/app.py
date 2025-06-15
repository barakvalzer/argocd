from flask import Flask
import requests
import os

app = Flask(__name__)
BACKEND_URL = os.getenv("BACKEND_URL", "http://backend:5000")

@app.route('/')
def home():
    r = requests.get(BACKEND_URL)
    return f"Frontend says: {r.json()['message']}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.getenv("PORT", 5000)))
