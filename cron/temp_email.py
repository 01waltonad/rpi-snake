# saves the temp readings into influx - email out if low temp
import os
import glob
import time
from influxdb import InfluxDBClient
import subprocess
os.system('modprobe w1-gpio')
os.system('modprobe w1-therm')

device_file_snake1 =  '/sys/bus/w1/devices/28-0000006a28bd/w1_slave'  # update file location for temp sensors 1 and 2
device_file_snake2 = '/sys/bus/w1/devices/28-00000094eca7/w1_slave'   # update file location for temp sensors 1 and 2 
  

## snake1
def read_temp_raw_snake1():
	f = open(device_file_snake1, 'r')
	lines = f.readlines()
	f.close()
	return lines

def read_temp_snake1():
	lines = read_temp_raw_snake1()
	while lines[0].strip()[-3:] != 'YES':
		time.sleep(0.2)
		lines = read_temp_raw_snake1()
	equals_pos = lines[1].find('t=')
	if equals_pos != -1:
		temp_string = lines[1][equals_pos+2:]
		temp_c = float(temp_string) / 1000.0
		return temp_c
## snake2
def read_temp_raw_snake2():
	f = open(device_file_snake2, 'r')
	lines = f.readlines()
	f.close()
	return lines

def read_temp_snake2():
	lines = read_temp_raw_snake2()
	while lines[0].strip()[-3:] != 'YES':
		time.sleep(0.2)
		lines = read_temp_raw_snake2()
	equals_pos = lines[1].find('t=')
	if equals_pos != -1:
		temp_string = lines[1][equals_pos+2:]
		temp_c = float(temp_string) / 1000.0
		return temp_c

# email out if temp less then 20
if (read_temp_snake1()) < 20:
        text = "Snake 1 temperature is low "								# update email address
        subprocess.run(
           ["mail", "-s", "Snake 1 Temperature is low, Please check bulb", "your@email.com"],                          
         input=text, text=True, check=True)
if (read_temp_snake2()) < 20:
        text = "Snake 2 temperature is low "								# update email address
        subprocess.run(
           ["mail", "-s", "Snake 2 Temperature is low, Please check bulb", "your@email.com"], 
         input=text, text=True, check=True)


# add to influx
temp_date = [
	{
	"measurement" : "temp",
	"tags" : {
	"host": "Snake_Temps_email"														
},
"fields" : {
	"temp_snake1" : float(read_temp_snake1()),
	"temp_snake2" : float(read_temp_snake2()),
}
}
]

client = InfluxDBClient('localhost', 8086, 'influx_username', 'influx_password', 'influx_database')        # update to own username password and database set up before
client.write_points(temp_date)
