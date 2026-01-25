from flask import Flask, Response
from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST
import time

app = Flask(__name__)

REQUEST_COUNT = Counter("http_requests_total", "HTTP requests", ["method", "endpoint"])
REQUEST_LATENCY = Histogram("http_request_latency_seconds", "Request latency")

@app.route("/health")
def health():
    return {"status": "UP"}, 200

@app.route("/")
def index():
    REQUEST_COUNT.labels("GET", "/").inc()
    start = time.time()
    time.sleep(0.1)
    REQUEST_LATENCY.observe(time.time() - start)
    return "Azure AKS DevOps Interview Demo"

@app.route("/metrics")
def metrics():
    return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)
