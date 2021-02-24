#!/bin/bash

cd ~/mydevel/forest-monitor-dev/geoserver

docker build -t forestmonitor/geoserver:2.18.1 .

docker run -d \
           --restart unless-stopped --name forest_monitor_geoserver \
           -p 127.0.0.1:8001:8080 \
           -e "GEOSERVER_URL=/forest-monitor" \
           -e "GEOSERVER_DATA_DIR=/opt/geoserver/data_dir" \
           -v forest_monitor_geoserver_vol:/opt/geoserver/data_dir \
           forestmonitor/geoserver:2.18.1
