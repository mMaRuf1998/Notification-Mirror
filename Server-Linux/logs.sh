#!/bin/bash

LOG="$HOME/.local/share/notification-mirror/notifications.log"

if [ ! -f "$LOG" ]; then
    echo "No notifications yet."
    exit 0
fi

echo ""
echo "  Recent notifications"
echo "  ─────────────────────────────────────────"
tail -n 30 "$LOG" | while IFS='|' read -r ts app title body; do
    printf "  %-20s %-15s %s\n" "$ts" "$(echo $app | xargs)" "$(echo $title | xargs): $(echo $body | xargs)"
done
echo ""
