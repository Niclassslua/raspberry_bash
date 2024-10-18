![raspi bash](https://github.com/Niclassslua/raspberry_bash/assets/78554432/19d5e655-00b8-42da-9426-de5b2dc167fb)



# raspberry_bash
This repository hosts a collection of useful and practical Bash scripts specifically designed for optimizing and automating tasks on Raspberry Pi devices.



## install_xrdp.sh

### Keyboard Layout Codes for xrdp

Below are the relevant keyboard layout codes that can be used to adjust the layout in your RDP sessions.

| Keyboard Layout           | Hex Code    |
|---------------------------|-------------|
| German (QWERTZ)           | 0x00000407  |
| US English (QWERTY)       | 0x00000409  |
| UK English (QWERTY)       | 0x00000809  |
| French (AZERTY)           | 0x0000040C  |
| Spanish                   | 0x0000040A  |
| Italian                   | 0x00000410  |
| Danish                    | 0x00000406  |
| Dutch                     | 0x00000413  |
| Norwegian                 | 0x00000414  |
| Swedish                   | 0x0000041D  |
| Swiss German (QWERTZ)     | 0x00000807  |
| Belgian (AZERTY)          | 0x0000080C  |
| Portuguese (Portugal)     | 0x00000816  |
| Canadian Multilingual     | 0x00001009  |
| Brazilian (ABNT2)         | 0x00000416  |
| Russian                   | 0x00000419  |
| Turkish                   | 0x0000041F  |
| Japanese                  | 0x00000411  |

### Instructions for Modifying the Bash Script

To adjust the Bash script for a different keyboard layout in your RDP session, follow these steps:

1. **Choose Your Layout Code**:
   - Use the table above to find the correct Hex Code for your preferred keyboard layout.

2. **Modify the Bash Script**:
   - Locate the following line in the script:
     ```bash
     echo "xrdp.override_keylayout=0x00000407" | sudo tee -a /etc/xrdp/xrdp.ini
     ```
   - Replace `0x00000407` (German QWERTZ) with the Hex Code of your desired layout. For example, if you want to use **US English (QWERTY)**, you would replace it with `0x00000409` like so:
     ```bash
     echo "xrdp.override_keylayout=0x00000409" | sudo tee -a /etc/xrdp/xrdp.ini
     ```

3. **Save and Run the Script**:
   - After modifying the script, save the changes and run it as usual. This will update your `xrdp.ini` configuration file and apply the new keyboard layout.

4. **Restart xrdp**:
   - The script already includes a command to restart the `xrdp` service, so no further action is needed. Once the script finishes running, your new keyboard layout will be active.
