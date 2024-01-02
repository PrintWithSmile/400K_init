#!/bin/bash
echo "Připojování k Wi-Fi síti..."
echo M118 Pripojuji se k WIFI siti $SSID s heslem $HESLO > ~/printer_data/comms/klippy.serial
nmcli device wifi connect "$SSID" password "$HESLO"

if [ $? -eq 0 ]; then
  ip_address=$(nmcli -g IP4.ADDRESS device show wlan0 | awk '{print $1}')
  response_msg="Wifi připojeno s touto IP adresou $ip_address"
else
  response_msg="Jméno wifi nebo heslo není správné, prosím zkus to znovu"
fi

# Výpis výsledku do tiskárny
echo M118 "$response_msg" > ~/printer_data/comms/klippy.serial
