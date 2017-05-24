# Raspberry Pi

Ipadress | localdns | location | master/slave
--- | --- | --- | ---
192.168.1.1|	pi1.local|	amsterdam|	master
192.168.1.2|	pi2.local|	shanghai|	slave
192.168.1.3|	pi3.local| 	chicago|	slave
192.168.1.4|	pi4.local| 	santiago|	slave
192.168.1.5|	pi5.local| 	marie|		slave
192.168.1.6|	pi6.local| 	melbourne|	slave
192.168.1.7|	pi7.local| 	johannesburg|	slave
# Hypriot
We use the Hypriot version v1.4.0</br>
<a>https://github.com/hypriot/image-builder-rpi/releases/download/v1.4.0/hypriotos-rpi-v1.4.0.img.zip</a>

# Configuration
For this to work you need a usb network adapter connected to your Raspberry Pi.</br>
Go to the config/master/root/etc/network/interfaces.d</br>
Check if the config of eth0 is correct so you can make a ssh connection with the Raspberry Pi, if you will not use ssh you can just leave the config as it is.</br>
Flash the master config from the config map to the sd card of your Raspberry PI.</br>
Now start your Raspberry Pi and configure it as below to make it work like a router.</br>

```
sudo apt-get update
sudo apt-get install hostapd
sudo apt-get install dhcpcd5
sudo apt-get install dnsmasq

This will ignore wlan0 when dhcpcd is running so it will not give him an Ip Address, because it is configured with a static one
Add ‘denyinterfaces wlan0’ to the end of ‘sudo nano /etc/dhcpcd.conf’
      
This will configure the Access Point on the Raspberry Pi:
Configure hostapd with the command ‘sudo nano /etc/hostapd/hostapd.conf'
Put these lines in the file:
      interface=wlan0 #interface you want to use
      ssid=SlimmeSpiegel #The name of the Access Point
      hw_mode=g #bandwidth, g stands for 2.4GHz band
      channel=2 #channel which will be used
      ieee80211n=1 #enable 802.11n
      wmm_enabled=1 #QoS support
      ht_capab=[HT40][SHORT-GI-20][DSSS_CKK-40] #enable 40 Mhz channel with 20ns interval
      wpa=2 #use WPA2
      wpa_key_mgmt=WPA-PSK #use a pre shared key
      pa_passphrase=INF2ASS2017
      rsn_pairwise=CCMP 
      wpa_pairwise=CCMP
      ignore_broadcast_ssid=0 #send out your ssid as visible
      
sudo hostapd -B /etc/hostapd/hostapd.conf to start your access point, -B will run it in the background

Configure the dhcp server on the Raspberry Pi:
sudo nano /etc/dnsmasq.conf
Put this in the file at the top
      interface = wlan0
      dhcp-range=192.168.2.10,192.168.2.250,255.255.255.0,12h (12 hour lease)
      
sudo service dhcpcd start

enable ipv4 forwarding on the Raspberry Pi:
sudo nano /etc/sysctl.conf’ and remove the # in the beginning of the line ‘net.ipv4.ip_forward=1’ this will enable it on the next boot, use ‘sudo sh -c “echo 1 > /proc/sys/net/ipv4/ip_forward”’ to enable it now

To share the eth0 connection with the wlan0 connection: 

	sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
	sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
	sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
	sudo sh -c “iptables-save > /etc/iptables.ipv4.nat” to safe the rules done above
	sudo nano /etc/rc.local and add above the line ‘exit 0’  the line :‘iptables-restore < /etc/iptables.ipv4.nat’

To share the eth1(network adapter) connection with the eth0 connection:
	Unknown working commands :)
	sudo iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
	sudo iptables -A FORWARD -i eth1 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
	sudo iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT
	sudo iptables -A FORWARD -I eth0 -j ACCEPT
	sudo iptables -A FORWARD -I eth1 -j ACCEPT
	sudo iptables -A FORWARD -I wlan0 -j ACCEPT
```
