#!/bin/bash

set +x

sudo systemctl start NetworkManager.service
sudo systemctl start wpa_supplicant.service



#!/bin/bash

# Enable debug mode if needed
set +x

# Get interface choice from the command line argument ($1)
interface_choice=$1

# Determine which interface to use based on the input variable
if [ "$interface_choice" -eq 1 ]; then
    interface="wlan1"
else
    interface="wlan0"
fi

# Stop network services
sudo systemctl stop NetworkManager.service
sudo systemctl stop wpa_supplicant.service

# Set the selected interface to monitor mode
sudo ifconfig $interface down
sudo iwconfig $interface mode managed
sudo ifconfig $interface up

echo "Interface $interface is now in managed mode."

