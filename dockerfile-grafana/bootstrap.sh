#!/bin/bash

service grafana-server start
#/usr/sbin/grafana-server -config /etc/grafana/grafana.ini &

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
