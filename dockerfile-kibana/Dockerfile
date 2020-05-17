FROM ubuntu:latest

LABEL Kibana 7.2.0 

# Kibana version
ENV KIBANA_VERSION 7.2.0

# Download each plugin and put it into files/ and change the filename here accordingly to downloaded plugin name
ENV ROR_KBN readonlyrest_kbn_pro-1.19.5_es7.2.0.zip
ENV ODA_KBN opendistro_alerting-1.7.0.0.zip

# Get unused UID/GID to avoid possible user/group mess
ENV KIBANA_UID 1101
ENV KIBANA_GID 1101

# Disable IPv6
RUN \
  echo 'net.ipv6.conf.default.disable_ipv6 = 1' > /etc/sysctl.d/20-ipv6-disable.conf; \
  echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.d/20-ipv6-disable.conf; \
  echo 'net.ipv6.conf.lo.disable_ipv6 = 1' >> /etc/sysctl.d/20-ipv6-disable.conf; \
  cat /etc/sysctl.d/20-ipv6-disable.conf; \
  sysctl -p;

# Install prerequisites
RUN \
    apt-get update && apt-get upgrade -y && apt-get install -y wget curl apt-transport-https gnupg && \
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
    echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-7.x.list && \
    apt-get update

# Add user:group with preset uid:gid
RUN \
  --addgroup --quiet \
             --gid ${KIBANA_GID} \ 
             kibana && \
  --useradd  --uid ${KIBANA_UID} \
             --gid kibana \
             --shell /bin/false \
             kibana 
 
 # Install kibana
 RUN \
   apt-get install kibana=${KIBANA_VERSION} && \
   update-rc.d kibana defaults 95 10
   
# Install plugins
COPY files/* /tmp/

RUN if [ ! -z "${ROR_KBN}" ]; then /usr/share/kibana/bin/kibana-plugin --allow-root install file:///tmp/${ROR_KBN}; fi
RUN if [ ! -z "${ODA_KBN}" ]; then /usr/share/kibana/bin/kibana-plugin --allow-root install file:///tmp/${ODA_KBN}; fi

# Increase heap size
RUN awk 'NR==1{print; print "NODE_OPTIONS=\"--max-old-space-size=2560\""} NR!=1' /usr/share/kibana/bin/kibana > /usr/share/kibana/bin/kibana.tmp && \
    mv /usr/share/kibana/bin/kibana.tmp /usr/share/kibana/bin/kibana && \
    chmod a+x /usr/share/kibana/bin/kibana

# Cleanup
RUN apt-get cleamn all && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
 
# Bootstrap

ADD files/bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh && chmod 700 /etc/bootstrap.sh

CMD ["/etc/bootstrap.sh", "-d"]

EXPOSE 5601
