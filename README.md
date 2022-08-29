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
**curl -sL https://raw.githubusercontent.com/Bicko/raspi-prep/master/start-script-XX_rpiX-XXXXX.sh | sudo bash**

See https://www.raspberrypi.com/news/raspberry-pi-bullseye-update-april-2022/ for info about the removal of the 'pi' default user and how to generate a username & password for headless use.
