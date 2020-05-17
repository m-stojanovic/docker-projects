FROM ubuntu:latest
RUN \
  apt-get update \
  apt-get install -y mysql-server
  apt-get clean all

RUN chown -R mysql:mysql /var/run/mysqld && chown -R mysql:mysql /var/lib/mysql && chown -R mysql:mysql /var/log/mysql

# Cleanup
RUN apt-get clean all && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER mysql

ADD start-mysql.sh start-mysql.sh

VOLUME /var/lib/mysql
VOLUME /var/log/mysql

EXPOSE 3306

CMD ["sh", "start-mysql.sh"]
