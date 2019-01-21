#!/bin/bash
VIP=192.168.5.10:80
RIP1=192.168.5.2
RIP2=192.168.5.8
for IP in $RIP1 $RIP2
do
  curl -s http://$IP &> /dev/null
  if [ $? -eq 0 ];then
    ipvsadm -Ln | grep -q $IP || ipvsadm -a -t $VIP -r $IP
  else
    ipvsadm -Ln | grep -q $IP && ipvsadm -d -t $VIP -r $IP
  fi
done
sleep 1

