#!/bin/bash -e

echo Installing Influxdb...
echo 
echo
sleep 2

wget -q https://repos.influxdata.com/influxdata-archive_compat.key
echo '393e8779c89ac8d958f81f942f9ad7fb82a25e133faddaf92e15b16e6ac9ce4c influxdata-archive_compat.key' | sha256sum -c && cat influxdata-archive_compat.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list
sudo apt-get update && sudo apt-get install influxdb -y
sudo systemctl unmask influxdb.service
sudo systemctl start influxdb
sudo apt install python3-influxdb -y
sleep 2
echo

# create database
echo createing database and user
echo
read -p "Database name: " dbase
read -p "user name: " uname
read -p "password: " pword
influx -execute "CREATE DATABASE "$dbase
influx -execute "CREATE USER "$uname" WITH PASSWORD '"$pword"'"
influx -execute "GRANT ALL ON "$dbase" to "$uname
echo
echo db suscessfuly created
sleep 5
exit 0


