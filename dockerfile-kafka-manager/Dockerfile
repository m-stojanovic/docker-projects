############################################################
# Dockerfile to get a kafka-manager
############################################################
# run with docker run -ti kafka-manager /etc/bootstrap.sh -bash
# minimal config is /opt/kafka-manager/conf/application.conf
# kafka-manager.zkhosts="my.zookeeper.host.com:2181"

FROM java:8

RUN \
  cd /opt && apt-get -y install git && \
  git clone https://github.com/yahoo/kafka-manager.git
RUN \
  apt-get install -y apt-transport-https && \
  echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823 && \
  apt-get update && apt-get -y install sbt
#RUN \
#  cd /opt/kafka-manager && sbt clean dist

ADD files/bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh && chmod 700 /etc/bootstrap.sh

CMD ["etc/bootstrap", "-d"]

# 9000 is default
# If need change , run docker with -e=9090 -p 9090:9090
# and /bin/kafka-manager -Dconfig.file=/path/to/application.conf -Dhttp.port=9090

EXPOSE 9000
