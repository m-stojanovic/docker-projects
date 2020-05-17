FROM ubuntu:latest

LABEL logstash 7.2.0

# Logstash version to install
ENV LS_VERSION 7.2.0

ENV LS_HOME /var/lib/logstash

# Get unused UID/GID to avoid possible user/group mess
ENV LS_UID 1099
ENV LS_GID 1099

# Disable IPv6
RUN \
  echo 'net.ipv6.conf.default.disable_ipv6 = 1' > /etc/sysctl.d/20-ipv6-disable.conf; \
  echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.d/20-ipv6-disable.conf; \
  echo 'net.ipv6.conf.lo.disable_ipv6 = 1' >> /etc/sysctl.d/20-ipv6-disable.conf; \
  cat /etc/sysctl.d/20-ipv6-disable.conf; \
  sysctl -p;

# Install prerequisites
RUN \
    apt-get update && apt-get upgrade -y && apt-get install -y sudo wget apt-transport-https curl gnupg logrotate rsyslog vim && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - && \
    echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list && \
    apt-get update && apt-get install -y --allow-unauthenticated oracle-java8-installer oracle-java8-set-default
    
# Add user:group (logstash:logstash) with preset uid:gid ($LS_UID:$LS_GID)
RUN \
  addgroup --quiet \
           --git &{LS_GID} \
           logstash && \
  useradd  --uid ${LS_UID} \
           --git logstash \
           --shell /bin/false \
           logstash
 
# Install logstash
RUN wget https://artifacts.elastic.co/downloads/logstash/logstash-${LS_VERSION}.deb && dpkg -i logstash-${LS_VERSION}.deb && rm logstash-${LS_VERSION}.deb
RUN /usr/share/logstash/bin/system-install /etc/logstash/startup.options sysv

# Have logstash stdout/stderr logs in /var/log/logstash
RUN sed -i 's#/var/log/#/var/log/logstash/#g' /etc/init.d/logstash

# Install plugins
COPY files/logstash-filter-math-1.0.gem $LS_HOME/
COPY files/logrotate_logstash /etc/logrotate.d/logstash
RUN /usr/share/logstash/bin/logstash-plugin install $LS_HOME/logstash-filter-math-1.0.gem && \
    /usr/share/logstash/bin/logstash-plugin install logstash-filter-translate && \
    /usr/share/logstash/bin/logstash-plugin install logstash-input-lumberjack
    
# Cleanup
RUN apt-get clean all && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Bootstrap
ADD files/bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh

CMD["/etc/bootstrap.sh", "-d"]

EXPOSE 5043
EXPOSE 5044
EXPOSE 5045
EXPOSE 5046
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
