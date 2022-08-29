# raspi-prep
## A collection of scripts to prepare a Raspberry Pi.

Beware: Some of these scripts build using Ubuntu Server, and some expect Raspbian!
Method:
1. dd the ISO to the RPi's SD card.
2. Add an empty (or otherwise) file, 'ssh', to the boot partition.
3. Put the prepared wpa_supplicant.conf file into the boot partition.
3a. Put the prepared userconf file into the boot partition (see notes below).
4. Put the SD card into the RPi and boot it.
5. SSH to the freshly booted RPi, with default credentials
6. Run the following:
**curl -sL https://raw.githubusercontent.com/Bicko/raspi-prep/master/start-script-XX_rpiX-XXXXX.sh | sudo bash**

See https://www.raspberrypi.com/news/raspberry-pi-bullseye-update-april-2022/ for info about the removal of the 'pi' default user and how to generate a username & password for headless use:

"To set up a user on first boot and bypass the wizard completely, create a file called userconf or userconf.txt in the boot partition of the SD card; this is the part of the SD card which can be seen when it is mounted in a Windows or MacOS computer.

This file should contain a single line of text, consisting of username:encrypted- password – so your desired username, followed immediately by a colon, followed immediately by an encrypted representation of the password you want to use.

To generate the encrypted password, the easiest way is to use OpenSSL on a Raspberry Pi that is already running – open a terminal window and enter

echo 'mypassword' | openssl passwd -6 -stdin

This will produce what looks like a string of random characters, which is actually an encrypted version of the supplied password."
