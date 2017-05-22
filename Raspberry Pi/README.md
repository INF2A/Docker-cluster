# Raspberry Pi
eerst handleiding volgen van Remco.

# Hypriot
config files kopieren nadat image is gecopyt

hypriotos-rpi-v1.4.0.img

```
git status
git add
git commit


1.	sudo apt-get update
2.	Install the access point package with ‘sudo apt-get install hostapd’
3.	Install the dhcpcd package with ‘sudo apt-get install dhcpcd5’
4.	Install the dnmasq package with ‘sudo apt-get install dnsmasq
5.	Add ‘denyinterfaces wlan0’ to the end of ‘sudo nano /etc/dhcpcd.conf’
6.	Edit the wlan0 section with ‘sudo nano /etc/network/interfaces.d/wlan0’
7.	  auto wlan0
      allow-hotplug wlan0
      iface wlan0 inet static
      address 192.168.2.1
      netmask 255.255.255.0
      network 192.168.2.1
      broadcast 192.168.2.255
8.	Configure hostapd with the command ‘sudo nano /etc/hostapd/hostapd.conf'
9.	Put these lines in the file:
    interface=wlan0 #interface you want to use
    ssid=SlimmeSpiegel
    hw_mode=g #bandwidth
    channel=2 #channel
    ieee80211n=1 #enable 802.11n
    wmm_enabled=1 #enable wmm
    ht_capab=[HT40][SHORT-GI-20][DSSS_CKK-40] #enable 40 Mhz channel with 20ns interval
    wpa=2 #use WPA2
    wpa_key_mgmt=WPA-PSK #use a pre shared key
    wpa_passphrase=INF2ASS2017
    rsn_pairwise=CCMP 
    wpa_pairwise=CCMP
    ignore_broadcast_ssid=0 (send out your ssid as visible)
10.	sudo hostapd -B /etc/hostapd/hostapd.conf to start your access point in background
11.	Configure dnsmasq with the command ‘sudo nano /etc/dnsmasq.conf
12.	Put this in the file at the top
    interface = wlan0
    dhcp-range=192.168.2.10,192.168.2.250,255.255.255.0,12h (12 hour lease)
13.	‘sudo service dhcpcd start’
14.	Enter command ‘sudo nano /etc/sysctl.conf’ and remove the # in the beginning of the line ‘net.ipv4.ip_forward=1’ this will    enable it on the next boot, use ‘sudo sh -c “echo 1 > /proc/sys/net/ipv4/ip_forward”’ to enable it now
15.	To share the eth0 connection with the wlan0 connection use these commands: 
16.	sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
17.	sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
18.	sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
19.	sudo sh -c “iptables-save > /etc/iptables.ipv4.nat” to safe the rules done above
20.	sudo nano /etc/rc.local and add above the line ‘exit 0’  the line :‘iptables-restore < /etc/iptables.ipv4.nat’


21.	sudo iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
22.	sudo iptables -A FORWARD -i eth1 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
23.	sudo iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT
24.	sudo iptables -A FORWARD -I eth0 -j ACCEPT
25.	sudo iptables -A FORWARD -I eth1 -j ACCEPT
26.	sudo iptables -A FORWARD -I wlan0 -j ACCEPT

```
