#!/bin/bash

# Update the system and upgrade installed packages
sudo apt-get update && sudo apt-get upgrade -y

# Install xrdp
sudo apt-get install -y xrdp

# Enable and start xrdp service
sudo systemctl enable xrdp
sudo systemctl start xrdp

# Optional: Adjust desktop environment to prevent connection issues
# Modifying startwm.sh to avoid potential connection problems
sudo sed -i.bak '/^test -x \/etc\/X11\/Xsession && exec \/etc\/X11\/Xsession$/s/^/#/' /etc/xrdp/startwm.sh
sudo sed -i '/^exec \/bin\/sh \/etc\/X11\/Xsession$/s/^/#/' /etc/xrdp/startwm.sh
echo "startlxde" | sudo tee -a /etc/xrdp/startwm.sh

# Set keyboard layout override for German QWERTZ in xrdp.ini
sudo sed -i '/keyboard_layout=/d' /etc/xrdp/xrdp.ini
echo "xrdp.override_keylayout=0x00000407" | sudo tee -a /etc/xrdp/xrdp.ini

# Restart xrdp service to apply changes
sudo systemctl restart xrdp

echo "xrdp installation and setup complete with German QWERTZ keyboard layout. You can now connect to your Raspberry Pi via Remote Desktop."
