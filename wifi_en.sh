#!/bin/bash

echo M118 Connecting to WIFI site $SSID with password $PASSWORD > ~/printer_data/comms/klippy.serial
nmcli device wifi connect "$SSID" password "$PASSWORD"

if [ $? -eq 0 ]; then
  ip_address=$(nmcli -g IP4.ADDRESS device show wlan0 | awk '{print $1}')
  response_msg="WIFI connected, ip address is $ip_address"
else
  response_msg="WIFI SSID or password is not correct, please try again"
fi

# Výpis výsledku do tiskárny
echo M118 "$response_msg" > ~/printer_data/comms/klippy.serial
