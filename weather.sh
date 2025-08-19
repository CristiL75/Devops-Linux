#!/bin/bash
set -euo pipefail

echo "[INFO] Pornesc scriptul weather.sh"

if [ -f /etc/default/weather ]; then
    echo "[INFO] Încarc variabilele din /etc/default/weather"
    . /etc/default/weather
fi
CITY="${CITY:-Timisoara}"
echo "[INFO] Orașul folosit: $CITY"

echo "[INFO] Obțin vremea de la wttr.in"
WEATHER=$(curl -s "wttr.in/$CITY?format=1")

echo "$(date "+%Y-%m-%d %H:%M:%S") - $CITY - $WEATHER" >> /var/log/weather.log

HOSTNAME=$(hostname)
TIME=$(date "+%Y-%m-%d %H:%M:%S")
UPTIME=$(uptime -p)
DISK=$(df -h / | awk 'NR==2 {print $4 " free of " $2}')

echo "[INFO] Generez /etc/motd"
tee /etc/motd > /dev/null <<EOF
========================================
 Welcome and good weather
========================================
City: $CITY
Weather: $WEATHER
Hostname: $HOSTNAME
Time: $TIME
Uptime: $UPTIME
Disk free: $DISK
========================================