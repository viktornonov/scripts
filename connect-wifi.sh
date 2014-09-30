#!/bin/bash
sudo stop network-manager
sudo smbd reload
sudo iwconfig wlan0 essid $1
sudo dhclient wlan0
