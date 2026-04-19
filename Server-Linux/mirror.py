#!/usr/bin/env python3
import base64
import os
import subprocess
import tempfile
import threading
from datetime import datetime
from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route("/notify", methods=["POST"])
def receive():
    data = request.get_json(force=True, silent=True)
    if data:
        threading.Thread(target=process_items, args=(data,), daemon=True).start()
    return jsonify({"status": "ok"})

def process_items(data):
    items = data if isinstance(data, list) else [data]
    for item in items:
        title = item.get("title", "Notification")
        body = item.get("body", "")
        icon_b64 = item.get("icon", "")
        app_name = item.get("app", "Phone")

        icon_path = None
        if icon_b64:
            try:
                with tempfile.NamedTemporaryFile(suffix=".png", delete=False) as tmp:
                    tmp.write(base64.b64decode(icon_b64))
                    icon_path = tmp.name
            except: pass
            
        summary = title if title else app_name

        cmd = [
            "notify-send",
            "-a", app_name,
            "-i", icon_path or "dialog-information",
            "-t", "6000",
            summary,
            body
        ]

        try:
            subprocess.run(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        except Exception as e:
            print(f"Error showing notification: {e}")

        if icon_path: 
            threading.Timer(15.0, lambda: os.unlink(icon_path) if os.path.exists(icon_path) else None).start()
        print(f"[{datetime.now().strftime('%H:%M:%S')}] {app_name} | {title}: {body}")

if __name__ == "__main__":
    import socket
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        s.connect(("8.8.8.8", 80))
        ip = s.getsockname()[0]
    except: ip = "127.0.0.1"
    finally: s.close()

    print(f"\nMirror Server: http://{ip}:5000\n")
    import logging
    logging.getLogger('werkzeug').setLevel(logging.ERROR)
    app.run(host="0.0.0.0", port=5000)

