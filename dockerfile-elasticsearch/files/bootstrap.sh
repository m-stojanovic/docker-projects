#!/bin/bash

IFS=`,`

chown -R elasticsearch:elasticsearch /var/log/elasticsearch & 
chown -R elasticsearch:elasticsearch /usr/shareelasticsearch & 
chown -R elasticsearch:elasticsearch /mnt/backup & 

for repodir in $( egrep '^path.repo' /etc/elasticsearch/elasticsearch.yml | sed 's/\[//;s/\]//' ); do
	chown -R elasticsearch:elasticsearch $repodir &
done
for datadir in $( egrep '^path.data' /etc/elasticsearch/elasticsearch.yml | awk '{print $2}'); do
  	chown -R elasticsearch:elasticsearch $datadir &
done

service elasticsearch start

cd /opt/es-sqlui/site-server/
node /opt/es-sqlui/site-server/node-server.js & 

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
