#!/bin/bash

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi

JAVA:

FROM ubuntu:latest

RUN \
    apt-get update                            && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get install -y --force-yes oracle-java8-installer && \
    rm -rf /var/lib/apt/lists/*               && \
    rm -rf /var/cache/oracle-jdk8-installer

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
