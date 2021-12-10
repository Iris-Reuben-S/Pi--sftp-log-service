#!/bin/sh

if [ ! -d "/home/pi/pi-logs" ] ; then
	mkdir /home/pi/pi-logs/
fi

filename=$(date +\%Y_\%m_\%d_\%H_\%M)
sudo zerotier-cli status -j | awk '/address/{print}' > /home/pi/pi-logs/$filename.log
echo $(/opt/vc/bin/vcgencmd measure_temp) >> /home/pi/pi-logs/$filename.log
#echo $(netstat -t) >> /home/pi/pi-logs/$filename.log
python /home/pi/log-service/parse-log.py $filename 
cat <<EOF | sftp test-pi@192.168.3.138
put -r /home/pi/pi-logs/*.json test-output/
EOF
