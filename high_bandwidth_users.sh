#!/bin/bash
#Cpanel users in the server having high bandwidth Usage (> 20 GB)

whmapi1 showbw |grep -w -E "maindomain:|totalbytes:|user:"  |awk '{print $2}' |awk '{printf("%s%s", $0, (NR%3 ? "," : "\n"))}' |sed 's/,/ /g' |sed "s/'//g" |awk '$2>2.14748365e10' |while read details; do 
	domain=$(awk '{print $1}' <<< $details); 
	user=$(awk '{print $3}' <<< $details); 
	bw=$(awk '{print ($2/1.07374182e9) }' <<< $details);
	echo "$HOSTNAME $user $domain "$bw"GB"; 
done
