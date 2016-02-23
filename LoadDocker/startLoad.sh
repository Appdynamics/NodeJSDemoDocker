#!/bin/bash

# Start Load
i=0
if [ $# -eq 0 ]; then
	IP=127.0.0.1
	echo "host ip default: " $IP  
else
	echo "host ip: " $1
	IP=$1	
 
fi
while true; do
i=$[$i+1]
echo "i value " $i	
echo "-------------------------"
echo " Generating Load....     "
echo "-------------------------"
ab -n 100 -s 360 http://${IP}:3000/userexperience
sleep 4s
ab -n 10 -s 360 http://${IP}:3000/recommendations
sleep 8s
ab -n 10 -s 360 http://${IP}:3000/recommendations
sleep 8s
ab -n 10 -s 360 http://${IP}:3000/recommendations
sleep 8s
ab -n 10 -s 360 http://${IP}:3000/recommendations&
ab -n 10 -s 360 http://${IP}:3000/userexperience&
ab -n 10 -s 360 http://${IP}:3000/userexperience&
ab -n 10 -s 360 http://${IP}:3000/userexperience
ab -n 10 -s 360 http://${IP}:3000/userexperience&
ab -n 10 -s 360 http://${IP}:3000/userexperience&
ab -n 10 -s 360 http://${IP}:3000/userexperience
sleep 4s
ab -n 10 -s 360 http://${IP}:3000/recommendations
sleep 8s
ab -n 10 -s 360 http://${IP}:3000/recommendations
sleep 8s
ab -n 10 -s 360 http://${IP}:3000/recommendations&
ab -n 10 -s 360 http://${IP}:3000/userexperience&
ab -n 10 -s 360 http://${IP}:3000/userexperience&
ab -n 10 -s 360 http://${IP}:3000/userexperience
ab -n 10 -s 360 http://${IP}:3000/userexperience&
ab -n 10 -s 360 http://${IP}:3000/userexperience&
ab -n 10 -s 360 http://${IP}:3000/userexperience
echo "-------------------------"
echo "done!!!!!!               "
echo "-------------------------"
done
