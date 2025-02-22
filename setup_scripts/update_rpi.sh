#!/bin/bash -e

# First do apt-get update
/usr/bin/sudo apt update
# Then the upgrade
/usr/bin/sudo apt upgrade -y
# Finally rpi-auto remove
/usr/bin/sudo apt autoremove


