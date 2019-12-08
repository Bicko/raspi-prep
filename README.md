# raspi-prep
## A collection of scripts to prepare a Raspberry Pi.

Beware: Some of these scripts build using Ubuntu Server, and some expect Raspbian!
Method:
1. dd the ISO to the RPi's SD card.
2. Add an empty (or otherwise) file, 'ssh', to the boot partition.
3. Put the prepared wpa_supplicant.conf file into the boot partition.
4. Put the SD card into the RPi and boot it.
5. SSH to the freshly booted RPi, with default credentials
6. Run the following:
**curl -sL https://raw.githubusercontent.com/Bicko/raspi-prep/master/start-script-03_rpi3-heating.sh | sudo bash**
