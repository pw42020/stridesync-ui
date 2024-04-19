"""Flask part of the application"""

import asyncio

from flask import Flask, request, jsonify

from .functions import runProgram, CHANNEL_NAME

app = Flask(__name__)


@app.route("/", methods=["GET"])
def index():
    return jsonify({"message": "Welcome to the SDP Team 1 Bluetooth Data Receiver!"})


@app.route("/download-bluetooth", methods=["GET"])
def data():
    """
    Receive data from the ESP32 and write it to a file.
    """
    try:
        asyncio.run(runProgram(CHANNEL_NAME))
        return jsonify({"message": "Data received and saved to file."})
    except Exception as e:
        return jsonify({"message": f"Error: {e}"}), 500
