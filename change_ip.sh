#!/bin/bash
INTERFACE="eth0"
MAX_CHANGES=10
LOG_FILE="./ip_change.log"

if [[ $EUID -ne 0 ]]; then
   echo "❌ This script must be run as root. Try: sudo $0"
   exit 1
fi
if ! command -v ifconfig &> /dev/null; then
    echo "❌ ifconfig not found. Please install net-tools."
    exit 1
fi
if ! ifconfig $INTERFACE &> /dev/null; then
    echo "❌ Network interface '$INTERFACE' not found."
    exit 1
fi

echo "=== IP Change Session Started at $(date) ===" >> "$LOG_FILE"

# Function to generate a unique random IP
generate_unique_ip() {
    local ip
    while true; do
        ip="10.0.2.$((RANDOM % 254 + 1))"
        if ! ip addr show $INTERFACE | grep -q "$ip"; then
            echo "$ip"
            return
        fi
    done
}
change_ip() {
    NEW_IP=$(generate_unique_ip)
    ifconfig $INTERFACE down
    ifconfig $INTERFACE $NEW_IP
    ifconfig $INTERFACE up
    echo "✅ IP changed to $NEW_IP"
    echo "$(date): Changed IP to $NEW_IP" >> "$LOG_FILE"
}

for ((i=0; i<MAX_CHANGES; i++)); do
    change_ip
    sleep 1
done

echo "=== Session Ended at $(date) ===" >> "$LOG_FILE"
