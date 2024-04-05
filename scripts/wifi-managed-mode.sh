#!/bin/bash

set +x

sudo ifconfig wlan0 down
sudo iwconfig wlan0 mode managed
sudo ifconfig wlan0 up
sudo systemctl start NetworkManager.service
sudo systemctl start wpa_supplicant.service
