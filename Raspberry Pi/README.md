# Raspberry Pi

mini handleinding voor Remco:</br>
1.eerste hypriot flashen met config map. //check of wlan0 en eth1 meekunnen worden gecopyt</br>
	1.1uitleg config map // wat kun je aanpassen aan elk bestand </br>
2.dan handleing van Remco uitvoeren. </br>

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

```
sudo apt-get update
sudo apt-get install hostapd
sudo apt-get install dhcpcd5
sudo apt-get install dnsmasq

Add ‘denyinterfaces wlan0’ to the end of ‘sudo nano /etc/dhcpcd.conf’

Edit the wlan0 section with ‘sudo nano /etc/network/interfaces.d/wlan0’
      auto wlan0
      allow-hotplug wlan0
      iface wlan0 inet static
      address 192.168.2.1
      netmask 255.255.255.0
      network 192.168.2.1
      broadcast 192.168.2.255
      
Configure hostapd with the command ‘sudo nano /etc/hostapd/hostapd.conf'
Put these lines in the file:
      interface=wlan0 #interface you want to use
      ssid=SlimmeSpiegel
      hw_mode=g #bandwidth
      channel=2 #channel
      ieee80211n=1 #enable 802.11n
      wmm_enabled=1 #enable wmm
      ht_capab=[HT40][SHORT-GI-20][DSSS_CKK-40] #enable 40 Mhz channel with 20ns interval
      wpa=2 #use WPA2
      wpa_key_mgmt=WPA-PSK #use a pre shared key
      pa_passphrase=INF2ASS2017
      rsn_pairwise=CCMP 
      wpa_pairwise=CCMP
      ignore_broadcast_ssid=0 (send out your ssid as visible)
      
sudo hostapd -B /etc/hostapd/hostapd.conf to start your access point in background

sudo nano /etc/dnsmasq.conf
Put this in the file at the top
      interface = wlan0
      dhcp-range=192.168.2.10,192.168.2.250,255.255.255.0,12h (12 hour lease)
      
sudo service dhcpcd start

sudo nano /etc/sysctl.conf’ and remove the # in the beginning of the line ‘net.ipv4.ip_forward=1’ this will enable it on the next boot, use ‘sudo sh -c “echo 1 > /proc/sys/net/ipv4/ip_forward”’ to enable it now
To share the eth0 connection with the wlan0 connection use these commands: 

	sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
	sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
	sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
	sudo sh -c “iptables-save > /etc/iptables.ipv4.nat” to safe the rules done above
	sudo nano /etc/rc.local and add above the line ‘exit 0’  the line :‘iptables-restore < /etc/iptables.ipv4.nat’

	Unknown working commands :)
	sudo iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
	sudo iptables -A FORWARD -i eth1 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
	sudo iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT
	sudo iptables -A FORWARD -I eth0 -j ACCEPT
	sudo iptables -A FORWARD -I eth1 -j ACCEPT
	sudo iptables -A FORWARD -I wlan0 -j ACCEPT
```
