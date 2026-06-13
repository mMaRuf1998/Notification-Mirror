Notification Mirror - Android to Linux
A complete solution to mirror Android notifications to your Linux desktop. Send notifications from your phone to a Linux PC with powerful filtering, scheduling, and theming options.

📱 Features
Android App
Real-time notification mirroring - Forward phone notifications to Linux desktop

App grouping - Organize and manage notifications by app

Scheduled notifications - Set delays for when notifications should appear on desktop

Dark/Light mode - Automatic or manual theme switching

Connection management - Configure server IP and port

Notification history - View forwarded notifications

Selective forwarding - Choose which apps to mirror

Battery optimization - Efficient background operation

Linux Server
Lightweight Flask server - Minimal resource usage

Native notifications - Uses notify-send for system integration

Icon support - Forward app icons to desktop

Multi-notification queue - Handles burst notifications gracefully

Automatic cleanup - Temporary file management

📋 Prerequisites
Linux Server
bash
# Install required packages
sudo apt install libnotify-bin python3-pip

# Install Python dependencies
pip3 install flask flask-cors
Android Phone
Android 6.0 (API 23) or higher

Notification access permission required

🚀 Installation
1. Linux Server Setup
bash
# Clone the repository
git clone https://github.com/yourusername/notification-mirror.git
cd notification-mirror

# Make server script executable
chmod +x server.py

# Run the server
python3 server.py
The server will start and display your local IP address:

text
Mirror Server: http://192.168.1.100:5000
2. Android App Setup
Install the APK

Download notification-mirror.apk

Enable "Install from unknown sources" if prompted

Grant Notification Access

Open the app

Tap "Enable Notification Access"

Find "Notification Mirror" in the list and enable it

Configure Server Connection

Enter your Linux server's IP address

Port defaults to 5000

Tap "Test Connection" to verify

Select Apps to Mirror (Optional)

Go to "App Settings"

Toggle which apps should send notifications

📖 Usage Guide
Android App Interface
Main Screen
Connection Status - Shows if connected to server

Quick Toggle - Enable/disable notification mirroring

Recent Notifications - History of forwarded notifications

Theme Switch - Toggle dark/light mode

App Grouping Screen
View all apps that have sent notifications

Group by app name with unread counts

Clear notifications per app or globally

Scheduling Screen
Set global delay for all notifications

Per-app delay overrides

Schedule types:

Instant - Send immediately

Custom delay - 5s, 10s, 30s, 1m, 5m, 10m, 30m, 1h

Quiet hours - Delay all notifications during specified times

Settings Screen
Server Configuration - IP, port, timeout settings

Notification Filters - Keywords to block/allow

Battery Saver Mode - Optimize for battery life

Do Not Disturb - Respect Android's DND mode

Icon Forwarding - Enable/disable app icon transmission

Linux Server Management
Run as a service (systemd)
Create service file:

bash
sudo nano /etc/systemd/system/notification-mirror.service
Add:

ini
[Unit]
Description=Notification Mirror Server
After=network.target

[Service]
Type=simple
User=yourusername
ExecStart=/usr/bin/python3 /path/to/server.py
Restart=on-failure

[Install]
WantedBy=multi-user.target
Enable and start:

bash
sudo systemctl enable notification-mirror
sudo systemctl start notification-mirror
View logs
bash
# Real-time logs
journalctl -u notification-mirror -f

# Last 100 lines
journalctl -u notification-mirror -n 100
🔧 Configuration
Server Options
Edit server.py to customize:

python
# Change port
app.run(host="0.0.0.0", port=8080)

# Notification duration (milliseconds)
"-t", "6000"  # Change from 6 seconds

# Enable debug logging
logging.getLogger('werkzeug').setLevel(logging.INFO)
Android App Settings
Settings are stored locally and include:

Server URL: http://192.168.1.100:5000/notify

Connection timeout: 5 seconds (default)

Retry attempts: 3

Max queue size: 100 notifications

📱 APK Build Instructions
If you want to build the APK yourself:

bash
# Install Android Studio or command line tools

# Build debug APK
./gradlew assembleDebug

# Build release APK (requires signing key)
./gradlew assembleRelease

# Output location:
# app/build/outputs/apk/debug/app-debug.apk
# app/build/outputs/apk/release/app-release.apk
🎨 Theme Customization
Light Mode
Background: White (#FFFFFF)

Text: Dark gray (#333333)

Accent: Material Blue (#2196F3)

Dark Mode
Background: Dark gray (#121212)

Text: Light gray (#EEEEEE)

Accent: Light Blue (#64B5F6)

🛡️ Security Considerations
For Home Network Use
Keep server on trusted network

Use firewall to restrict access:

bash
# Allow only local subnet
sudo ufw allow from 192.168.1.0/24 to any port 5000
For Internet Access (Advanced)
Set up reverse proxy with HTTPS (nginx + Let's Encrypt)

Add API key authentication

Use VPN (WireGuard/OpenVPN)

🐛 Troubleshooting
Server Issues
Error: notify-send: command not found

bash
sudo apt install libnotify-bin
Connection refused

Check if server is running: ps aux | grep server.py

Verify firewall: sudo ufw status

Test connectivity: curl http://localhost:5000/notify

Port already in use

bash
# Find process using port 5000
sudo lsof -i :5000
# Kill process
sudo kill -9 [PID]
Android Issues
No notifications received

Verify notification access is granted

Check server IP/port configuration

Test connection in app settings

Check if app is battery optimized (disable if needed)

Delayed notifications

Check scheduling settings

Disable battery saver mode

Increase app priority in Android settings

App crashes

Clear app cache/data

Reinstall APK

Check Android logs: adb logcat | grep NotificationMirror

📊 API Reference
Send Notification
Endpoint: POST /notify

Headers: Content-Type: application/json

Body (single):

json
{
  "title": "WhatsApp",
  "body": "John: See you at 5pm",
  "icon": "base64_encoded_png_string",
  "app": "WhatsApp",
  "timestamp": 1234567890
}
Body (batch):

json
[
  {
    "title": "Gmail",
    "body": "New email from Sarah",
    "app": "Gmail"
  },
  {
    "title": "Twitter",
    "body": "Someone liked your tweet",
    "app": "Twitter"
  }
]
