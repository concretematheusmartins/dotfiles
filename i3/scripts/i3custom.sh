#!/usr/bin/env bash
#/scripts/i3custom.sh
# --------------------------------------------------------------------------------
# Copyright (C) 2020 Matheus Martins <3mhenrique@gmail.com>
# License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law
# --------------------------------------------------------------------------------

#Requisitos
# vnstat / curl / neofetch 
function network(){
  downtotal=$(/usr/bin/vnstat -s | grep today | awk {'print $2$3'})
  uptotal=$(/usr/bin/vnstat -s | grep today | awk {'print $5$6'})
#  downtotal=$(cat /scripts/Output/downloadtotal)
#  uptotal=$(cat /scripts/Output/uploadtotal) 
  ipext=$(cat /scripts/Output/meuip)
}

function weather(){
  clima=$(cat /scripts/Output/i3clima)
}
function timeup(){
  minuto=$(awk -F "." '{print $1}'  /proc/uptime)  
#minuto=$(awk '{print $0/60}' /proc/uptime | sed 's/\.[^.]*//')
    if [ $minuto -le "3599" ]; then
        utime=$(uptime | awk '{printf $3$4}' | sed 's/,//')
      else if [ $minuto -le "86390" ]; then
        utime=$(uptime | awk '{printf $3}' | sed 's/:/h:/' | sed 's/,/m'/)
    else 
      utime=$(uptime | awk '{printf $3$4$5}' | sed 's/,/ /' | sed 's/,//')
      fi
    fi
#  utime=$(cat /scripts/Output/uptime)
}

function ram() {
#  used=$(free -m | awk 'NR==2{printf "| Mem:%sMB(%.2f%%)\n", $3,$3*100/$2 }')
#used=$(neofetch memory | awk '{printf "| Mem:"$2"(%.1f%%)",$2/$4*100}')
used=$(echo -n "| " && free -gh | grep "Mem" | awk {'print $3'})
}

i3status | while :
	do
		read line
        timeup
		network
		ram
        weather
        printf "%s\n" "$clima | DT:($downtotal) UT:($uptotal) | $ipext $used | U:$utime | $line" || exit 1
           done
