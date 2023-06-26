#!/bin/bash

# Define the array of MAC addresses and corresponding IP addresses
declare -A mac_ip_array=(
  ["11:22:33:44:55:66"]="192.168.1.10"
  ["AA:BB:CC:DD:EE:FF"]="192.168.1.20"
  ["12:34:56:78:90:AB"]="192.168.1.30"
)

# Loop through all network interfaces
for interface in $(ls /sys/class/net/); do
  # Get the MAC address of the current interface
  mac_address=$(cat /sys/class/net/"$interface"/address)

  # Check if the MAC address exists in the array
  if [[ -v mac_ip_array[$mac_address] ]]; then
    ip_address="${mac_ip_array[$mac_address]}"
    echo "MAC address $mac_address exists in the array. Setting IP address $ip_address on $interface."

    # Set the IP address on the corresponding interface
    sudo ifconfig "$interface" "$ip_address"

  else
    echo "MAC address $mac_address does not exist in the array."
  fi
done
