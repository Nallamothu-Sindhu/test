from flask import Flask
import os

app = Flask(__name__)

# Read configuration from environment variables
APP_NAME = os.getenv("APP_NAME", "MyFlaskApp")
ENV = os.getenv("ENV", "development")
VERSION = os.getenv("VERSION", "1.0")

@app.route("/")
def home():
    return f"Welcome to {APP_NAME} (v{VERSION}) running in {ENV} environment!"

if __name__ == "__main__":
    # Only for local development
    app.run(host="0.0.0.0", port=int(os.getenv("PORT", 5000)), debug=(ENV=="development"))
