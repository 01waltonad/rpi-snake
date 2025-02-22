# RPI - Snake

set up for rpi zero 2w and two temp sensors, for monitering two snake enclosure temperatures  
keeps a record of temperature in influxdb and email out a warning if below 20degreesc heat i.e. bulb has blown  
RPI will automaticaly update

# to do
- [x] install rpios lite
- [x] set up one wire
- [x] set up influxdb
- [x] set up email
- [x] set up temp script
- [x] set up email when cold job
- [x] set up auto update script
- [ ] set up crontab jobs
- [ ] test install script
- [x] 3d print file
- [ ] update email pdf

## prerequisites
- Raspberry pi Zero 2w
- DS18B20-Compatible Temperature Sensor x2
- gmail email address with app password set up  
        -https://github.com/01waltonad/rpi-snake/blob/main/images/pi-email-2022-update.pdf 


## RPI setup instructions
1) set up sensors as per diagram/image  
![One wire wireing diagram](images/One_wire_wireing_diagram.png)
2) install Raspos
3) install git on command line, clone files and run install script
    
        sudo apt install git -y && git clone https://github.com/01waltonad/rpi-snake.git && bash rpi-snake/Install.sh
       
> [!NOTE]
> ▪️Install script will create a database and set up email settings make a note of the settings used if planning on useing grafana  
> ▪️make sure to change 1-wire interface setting to enabled then reboot in raspi-config towards the end of the set up   
> ▪️make sure to reboot rpi to update settings

4) for the two sensors, make a note of the 1 wire folders starting with 28
   
        ls /sys/bus/w1/devices/
![One wire folders](images/one_wire_folders.png)





## 3d print files
all the 3d prints i used are on thingiverse  
[Rpi zero case](https://www.thingiverse.com/thing:2823027)  
[cable tile mounts](https://www.thingiverse.com/thing:5180246)


## notes etc
> [!NOTE]
> ls /sys/bus/w1/devices/ to find 1wire serial numbers and make a note




5) update 1wire interface in raspi-config and reboot - 3 interface, I8 1 wire
> sudo raspi-config
6) check 1 wire is working ok - this should show the two sensors
> ls /sys/bus/w1/devices/





3) 
> [!NOTE]
> insert bash command here for setup1#
4) run raspi-config and enable 1wire

git clone https://github.com/01waltonad/rpi-snake.git


