############################################################
# Dockerfile to build grafana
# Based on Ubuntu 
############################################################

FROM ubuntu:latest

RUN \
  echo 'net.ipv6.conf.default.disable_ipv6 = 1' > /etc/sysctl.d/20-ipv6-disable.conf; \
  echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.d/20-ipv6-disable.conf; \
  echo 'net.ipv6.conf.lo.disable_ipv6 = 1' >> /etc/sysctl.d/20-ipv6-disable.conf; \
  echo 'vm.max_map_count=262144' >> /etc/sysctl.d/21-elasticsearch.conf; \
  cat /etc/sysctl.d/20-ipv6-disable.conf; \
  sysctl -p;
  
# Add Dockerfile inside the /root directory of the container
ADD Dockerfile /root/Dockerfile

# Install prerequisites
RUN apt-get clean all && apt-get update && apt-get install -y wget libfontconfig wget adduser openssl ca-certificates apt-transport-https

RUN \
  wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
	apt-get clean all && \
	apt-get update && apt-get upgrade -y --force-yes && \
        apt-get install -y --force-yes grafana=4.4.1

RUN mkdir -p /var/lib/grafana /var/lib/grafana/sessions /var/log/grafana /usr/share/grafana/dashboards
RUN chown grafana:grafana -R /var/log/grafana && \
    chown grafana:grafana -R /var/lib/grafana && \
    chown grafana:grafana -R /usr/share/grafana/dashboards

# Mapping the volumes
VOLUME ["/var/lib/grafana"]
VOLUME ["/var/log/grafana"]
VOLUME ["/usr/share/grafana"]
VOLUME ["/etc/grafana"]

WORKDIR /usr/share/grafana

# Add bootstrap script
ADD bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh && chmod 700 /etc/bootstrap.sh

# Cleanup
RUN apt-get clean all && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#CMD ["/etc/bootstrap.sh", "-d"]

EXPOSE 3001

ENTRYPOINT ["/usr/sbin/grafana-server", "-config", "/etc/grafana/grafana.ini"]
