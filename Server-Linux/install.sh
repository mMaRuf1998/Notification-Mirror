#!/bin/bash

set -e

INSTALL_DIR="$HOME/.local/bin/notification-mirror"
SERVICE_DIR="$HOME/.config/systemd/user"
SERVICE_NAME="notification-mirror.service"

echo ""
echo "  Installing Notification Mirror..."
echo ""

echo "  [1/4] Installing Python dependencies..."
pip install flask flask-cors --break-system-packages -q


if ! command -v notify-send &>/dev/null; then
    echo "  [2/4] Installing libnotify-bin..."
    sudo apt install -y libnotify-bin -q
else
    echo "  [2/4] notify-send already installed"
fi

echo "  [3/4] Copying files to $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"
cp mirror.py "$INSTALL_DIR/mirror.py"
chmod +x "$INSTALL_DIR/mirror.py"

echo "  [4/4] Setting up systemd service..."
mkdir -p "$SERVICE_DIR"
cp notification-mirror.service "$SERVICE_DIR/$SERVICE_NAME"
systemctl --user daemon-reload
systemctl --user enable "$SERVICE_NAME"
systemctl --user start "$SERVICE_NAME"
echo ""
echo "  Done! Service is running."
echo ""
echo "  Commands:"
echo "    Status:  systemctl --user status notification-mirror"
echo "    Logs:    journalctl --user -u notification-mirror -f"
echo "    Stop:    systemctl --user stop notification-mirror"
echo "    Restart: systemctl --user restart notification-mirror"
echo ""
IP=$(python3 -c "import socket; s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM); s.connect(('8.8.8.8',80)); print(s.getsockname()[0]); s.close()" 2>/dev/null || echo "unknown")
echo "  Enter this IP in your Android app: $IP"
echo ""
