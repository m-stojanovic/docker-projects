#!/bin/bash

chown -R logstash:logstash /var/log/logstash
service logstash start

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
