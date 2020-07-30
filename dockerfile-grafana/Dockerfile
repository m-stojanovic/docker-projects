# Dockerfile to build grafana
# Based on Ubuntu 
# Milos Stojanovic 
# email: mistojanovic@carnegietechnologies.com
############################################################

FROM ubuntu:20.04

# Disable ipv6 
RUN \
  echo 'net.ipv6.conf.default.disable_ipv6 = 1' > /etc/sysctl.d/20-ipv6-disable.conf; \
  echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.d/20-ipv6-disable.conf; \
  echo 'net.ipv6.conf.lo.disable_ipv6 = 1' >> /etc/sysctl.d/20-ipv6-disable.conf; \
  cat /etc/sysctl.d/20-ipv6-disable.conf; \
  sysctl -p;
  
# Add Dockerfile inside the /root directory of the container
ADD Dockerfile /root/Dockerfile

# Disable Debian default frontend debconf warnings
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

# Install prerequisites
RUN apt-get clean all && apt-get update && \ 
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get install --no-install-recommends -y gnupg2 wget libfontconfig adduser openssl ca-certificates apt-transport-https


#RUN pip3 install readline

# Add grafana gpg.key and repository
RUN wget -q -O - https://packages.grafana.com/gpg.key | apt-key add - && \
    echo "deb https://packages.grafana.com/oss/deb stable main" | tee -a /etc/apt/sources.list.d/grafana.list 

# Install grafana 
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y grafana
#RUN apt-get clean all && \

RUN mkdir -p /var/lib/grafana /var/lib/grafana/sessions /var/log/grafana /usr/share/grafana/dashboards && \
    chown grafana:grafana -R /var/log/grafana && \
    chown grafana:grafana -R /var/lib/grafana && \
    chown grafana:grafana -R /usr/share/grafana/dashboards

# Mapping the volumes
VOLUME ["/var/lib/grafana"]
VOLUME ["/var/log/grafana"]
VOLUME ["/usr/share/grafana"]
VOLUME ["/etc/grafana"]

# Set working dir in the container
WORKDIR /usr/share/grafana

# Add bootstrap script
COPY bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh && chmod 700 /etc/bootstrap.sh

# Cleanup
RUN apt-get clean all && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#CMD ["/etc/bootstrap.sh", "-d"]

EXPOSE 3000

ENTRYPOINT ["/usr/sbin/grafana-server", "-config", "/etc/grafana/grafana.ini"]
