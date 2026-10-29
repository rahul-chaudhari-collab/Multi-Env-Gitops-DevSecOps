import os
from flask import Flask, jsonify

app = Flask(__name__)

APP_NAME = os.getenv("APP_NAME", "GitOps DevSecOps Platform")
APP_VERSION = os.getenv("APP_VERSION", "1.0.0")
ENVIRONMENT = os.getenv("ENVIRONMENT", "development")


@app.route("/")
def home():
    return jsonify({
        "application": APP_NAME,
        "version": APP_VERSION,
        "environment": ENVIRONMENT,
        "message": "Welcome to the Multi-Environment GitOps + DevSecOps Platform"
    })


@app.route("/health")
def health():
    return jsonify({
        "status": "healthy"
    }), 200


@app.route("/info")
def info():
    return jsonify({
        "application": APP_NAME,
        "version": APP_VERSION,
        "environment": ENVIRONMENT
    })


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.getenv("PORT", "5000")))
