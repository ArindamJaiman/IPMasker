#!/bin/bash

INTERFACE="eth0"  # Network interface
MAX_CHANGES=10    # Number of IP changes

change_ip() {
    NEW_IP="10.0.2.$((RANDOM % 254 + 1))"
    sudo ifconfig $INTERFACE down
    sudo ifconfig $INTERFACE $NEW_IP
    sudo ifconfig $INTERFACE up
    echo "IP address changed to $NEW_IP"
}

for ((i=0; i<MAX_CHANGES; i++)); do
    change_ip
    sleep 1
done
