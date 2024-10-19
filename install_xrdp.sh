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

# Interactively ask for the new username
read -p "Enter the name of the new user for xrdp: " NEW_USER

# Create the new user
sudo adduser $NEW_USER

# Interactively ask for the password
echo "Set a password for the new user '$NEW_USER':"
sudo passwd $NEW_USER

# Add the new user to the sudo group
sudo usermod -aG sudo $NEW_USER

# Interactively choose the keyboard layout for xrdp
echo "Choose your keyboard layout for xrdp:"
echo "1) German (QWERTZ)"
echo "2) US English (QWERTY)"
echo "3) UK English (QWERTY)"
echo "4) French (AZERTY)"
echo "5) Spanish"
read -p "Enter the number corresponding to your keyboard layout: " LAYOUT_CHOICE

# Map the user's choice to the appropriate layout code
case $LAYOUT_CHOICE in
    1)
        LAYOUT_CODE="0x00000407"
        ;;
    2)
        LAYOUT_CODE="0x00000409"
        ;;
    3)
        LAYOUT_CODE="0x00000809"
        ;;
    4)
        LAYOUT_CODE="0x0000040C"
        ;;
    5)
        LAYOUT_CODE="0x0000040A"
        ;;
    *)
        echo "Invalid choice, defaulting to US English (QWERTY)"
        LAYOUT_CODE="0x00000409"
        ;;
esac

# Set keyboard layout override in xrdp.ini
sudo sed -i '/keyboard_layout=/d' /etc/xrdp/xrdp.ini
echo "xrdp.override_keylayout=$LAYOUT_CODE" | sudo tee -a /etc/xrdp/xrdp.ini

# Restart xrdp service to apply changes
sudo systemctl restart xrdp

# Final messages
echo "xrdp installation and setup complete with the selected keyboard layout ($LAYOUT_CODE)."
echo "A new sudo user '$NEW_USER' has been created."
echo "You can now connect to your Raspberry Pi via Remote Desktop using the '$NEW_USER' account."
