from flask import Flask, jsonify
import requests

app = Flask(__name__)

@app.route('/')
def home():
    return "Hello from Flask app!"

@app.route('/esp32-data')
def esp32_data():
    try:
        # Replace with the actual endpoint of your ESP32 server that provides data
        esp_response = requests.get('http://[fc94:c177:7869:7bf3:4205:5cb7:4020:57e9]/data-endpoint')
        return jsonify(esp_response.json())
    except requests.RequestException as error:
        return jsonify({"error": str(error)})
