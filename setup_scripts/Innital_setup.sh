#!/bin/bash -e
# RPI-Snake setup 1
# updates config file, updates rpi then reboots ready for stage 2


sudo cp /boot/firmware/config.txt  /boot/firmware/config.txt.back # copys origional config file
sudo cp /boot/firmware/config.txt  config.txt # copys origional config file
### check this bit sets up one wire ok

sudo chmod 777 config.txt # changes permission to write
printf "\n\n\ndtoverlay=w1-gpio " >> /config.txt # adds onewire onto config file
sudo chmod 755 config.txt #  changes permission back
sudo cp config.txt/boot/firmware/config.txt

###

sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
sudo localedef -i en_US -f UTF-8 en_US.UTF-8 # error came up on influx adding this to try and remove error
sudo localedef -i en_GB -f UTF-8 en_GB.UTF-8 # sorts out location issue. not sure why this appearing on new install or at top? worked after rebooting
#sudo raspi-config # reboot after setting up one wire
