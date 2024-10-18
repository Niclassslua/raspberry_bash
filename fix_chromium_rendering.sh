#!/bin/bash

# Path to the config.txt file
CONFIG_FILE="/boot/config.txt"

# Check if the line exists and is not already commented out
if grep -q "^dtoverlay=vc4-fkms-v3d" "$CONFIG_FILE"; then
    echo "Disabling dtoverlay=vc4-fkms-v3d..."
    # Comment out the line
    sudo sed -i 's/^dtoverlay=vc4-fkms-v3d/#dtoverlay=vc4-fkms-v3d/' "$CONFIG_FILE"
    echo "dtoverlay=vc4-fkms-v3d has been successfully disabled."
else
    echo "dtoverlay=vc4-fkms-v3d is already disabled or not present."
fi

# Prompt for reboot
read -p "Do you want to reboot the Raspberry Pi now? (y/n): " answer
if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    echo "Rebooting the Raspberry Pi..."
    sudo reboot
else
    echo "Reboot cancelled. Changes will take effect after the next reboot."
fi
