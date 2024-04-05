#!/bin/bash

set +x

sudo systemctl stop NetworkManager.service
sudo systemctl stop wpa_supplicant.service
sudo ifconfig wlan0 down
sudo iwconfig wlan0 mode monitor
sudo ifconfig wlan0 up
