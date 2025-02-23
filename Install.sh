#!/bin/bash -e
# andrew rpi-Snake setup
# updates rpi
# installs influx and mail
# sets up 

#updates rpi
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
sudo localedef -i en_US -f UTF-8 en_US.UTF-8 # sorts out location issue. not sure why this appearing on new install
sudo localedef -i en_GB -f UTF-8 en_GB.UTF-8 # sorts out location issue. not sure why this appearing on new install
echo
echo

# influx db install
echo Installing Influxdb...
echo 
echo
sleep 2
# gets key data and addes new repository
wget -q https://repos.influxdata.com/influxdata-archive_compat.key
echo '393e8779c89ac8d958f81f942f9ad7fb82a25e133faddaf92e15b16e6ac9ce4c influxdata-archive_compat.key' | sha256sum -c && cat influxdata-archive_compat.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list
# installs influx and python3 tools needed
sudo apt-get update && sudo apt-get install influxdb -y && sudo apt install python3-influxdb -y
sudo systemctl unmask influxdb.service
sudo systemctl start influxdb
echo
echo

# installs email files
echo installing email files
echo
echo
sleep 2
sudo apt install msmtp msmtp-mta mailutils mpack ca-certificates -y
sudo touch /etc/msmtprc
echo
echo

#creates influx database
echo createing database and user
echo
read -p "Influx Database name: " dbase
read -p "Influx user name:     " uname
read -p "Influx password:      " pword
influx -execute "CREATE DATABASE "$dbase
influx -execute "CREATE USER "$uname" WITH PASSWORD '"$pword"'"
influx -execute "GRANT ALL ON "$dbase" to "$uname
echo
echo db suscessfuly created
sleep 2
echo
echo

# gatheres required info for email setup
echo email set up
echo
echo
read -p "From Email First Name:               " fname
read -p "From email Last Name:                " sname
read -p "From Email Address:                  " email
read -p "From Email App password (No Spaces): " pword

# creates email settings file
printf "account default \nhost smtp.gmail.com \nport 587 \nlogfile /tmp/msmtp.log \ntls on \ntls_starttls on \ntls_trust_file /etc/ssl/certs/ca-certificates.crt \nauth login \nuser "$email" \npassword "$pword" \nfrom "$fname" "$sname" \naccount account2" >> emailsettings.txt
sudo cp emailsettings.txt /etc/msmtprc

echo
echo
read -p "Send Test email (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
	then
	read -p "Recipicant email address: " toemail
	echo -e "Subject: Test Mail\r\n\r\nThis is a test mail" |msmtp --debug --from=default -t $toemail

fi

# moves crontab files
sudo cp rpi-snake/cron/temp.py /etc/temp.py
sudo cp rpi-snake/cron/temp_email.py /etc/temp_email.py
sudo cp rpi-snake/cron/update_rpi.sh /etc/update_rpi.sh

# Get the existing crontab content
existing_crontab=$(crontab -l 2>/dev/null)
# Add the scheduled job to the existing crontab content
new_crontab="${existing_crontab}
*/30 * * * * python3 /etc/temp.py
5 */6 * * * python3 /etc/temp_email.py
10 2 * * * bash /etc/update_rpi.sh"

# Install the modified crontab
echo "$new_crontab" | crontab -
crontab -l | grep curl


echo
echo

# raspi config message
read -p "Please enable 1 wire in interface settings then reboot: press any key to continue " 
sudo raspi-config







