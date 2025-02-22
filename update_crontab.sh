#!/bin/bash
# removes and copys cron files to etc so can add to crontab

sudo rm /etc/temp.py
sudo rm /etc/temp_email.py
sudo rm /etc/update_rpi.sh
cd
sudo cp rpi-snake/cron/temp.py /etc/temp.py
sudo cp rpi-snake/cron/temp_email.py /etc/temp_email.py
sudo cp rpi-snake/cron/update_rpi.sh /etc/update_rpi.sh


