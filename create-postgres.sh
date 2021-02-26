#!/bin/bash

sudo docker network create forest_monitor_net

sudo docker volume create forest_monitor_pg_vol

sudo docker run -d \
           --restart unless-stopped --name forest_monitor_pg \
           -p 0.0.0.0:5433:5432 \
           -v forest_monitor_pg_vol:/var/lib/postgresql/data \
           -e POSTGRES_PASSWORD="postgres" \
           --ipc=host \
           --shm-size 128m \
           postgis/postgis:11-2.5

sudo docker exec -it forest_monitor_pg bash -c "echo 'localhost:5432:forest_monitor:postgres:postgres' > /root/.pgpass;chmod 0600 /root/.pgpass"

sudo docker exec -it forest_monitor_pg bash -c "sed -i 's/max_connections = 100/max_connections = 1000/' /var/lib/postgresql/data/postgresql.conf"

sudo docker restart forest_monitor_pg

sudo docker network connect forest_monitor_net forest_monitor_pg
