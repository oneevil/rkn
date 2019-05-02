#!/bin/bash
wget -O dump.csv https://raw.githubusercontent.com/zapret-info/z-i/master/dump.csv
cut -d ";" -f1 dump.csv | tr '|' '\n' | tr -d ' ' | sort -t. -n -k1,1 -k2,2 -k3,3 -k4,4 | uniq | tail -n +3 > rkn_list.txt
python3 net_list.py rkn_list.txt 35000 | sort -t. -n -k1,1 -k2,2 -k3,3 -k4,4 > rkn_subnets.txt
cat rkn_subnets.txt | awk '{ print "add address="$0" list=rkn" }' > subnets.rsc
sed -i -e '1 s/^/\/ip firewall address-list\n/;' subnets.rsc
cat rkn_subnets.txt | awk '{ print "ipset add rkn address "$0 }' > subnets_ipset.rsc
