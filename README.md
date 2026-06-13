# 📱 Notification Mirror Linux-Android
Mirrors your Android notifications to your Linux desktop — instantly, locally. Reduce distractions. Keep your phone away.

## ✨ Features

- Real-time sync
- Notification Interval Setup
- Native notifications (`notify-send`)  
- App names, icons, avatars  
- 100% local (no cloud)  
- Lightweight
- Dark mode

---
## Demo

<p align="center">
  <img src="Notification Mirror.png" alt="Notification Mirror" width="250">
</p>

## 🚀 Quick Start

```bash
git clone <your-repo-url>
cd notification-mirror
pip install flask flask-cors
python server.py
```

- Open: `http://localhost:5000`  
- Use your IP in the Android app (port `5000`)

---

## 📱 Android Setup

- Install APK  
- Enter PC IP  
- Grant notification access  
- Start service  

---

## ⚙️ Requirements

- Linux + `notify-send`  
- Python 3
