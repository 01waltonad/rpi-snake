#!/bin/bash -e
#email set up

sudo apt install msmtp msmtp-mta mailutils mpack ca-certificates -y
sudo touch /etc/msmtprc

# gatheres required info
echo
echo
read -p "First Name: " fname
read -p "Last Name: " sname
read -p "Email Address: " email
read -p "Email App password (No Spaces): " pword

# creates settings file
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




