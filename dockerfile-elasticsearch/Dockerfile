FROM elasticsearch:7.7

LABEL ES 7.7.0

ENV ES_VERSION 7.7.0

# Download each plugin and put it into files/ and change the filename here accordingly to downloaded plugin name
ENV ROR_PLUGIN readonlyrest-1.19.5_es7.7.0.zip

ENV ODA_PLUGIN opendistro_alerting-1.7.0.0.zip

ENV SQL_PLUGIN elasticsearch-sql-7.7.0.0.zip


# Get unused UID/GID to avoid possible user/group mess
ENV ES_UID 1100
ENV ES_GID 1100

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Disable IPv6
RUN \ 
  echo 'net.ipv6.conf.default.disable_ipv6 = 1' > /etc/sysctl.d/20-ipv6-disable.conf; \
  echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.d/20-ipv6-disable.conf; \
  echo 'net.ipv6.conf.lo.disable_ipv6 = 1' >> /etc/sysctl.d/20-ipv6-disable.conf; \
  echo 'vm.max_map_count=262144' >> /etc/sysctl.d/21-elasticsearch.conf; \
  cat /etc/sysctl.conf; \
  cat /etc/sysctl.d/20-ipv6-disable.conf; \
  sysctl -p;

# Upragede system packages
RUN apt-get update && apt-get upgrade -y

# Install prerequisites
RUN \ 
  apt-get update && apt-get install -y sudo wget curl apt-transport-https gnupg unzip && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - && \
  echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list && \
  apt-get update && apt-get install -y --allow-unauthenticated oracle-java8-installer oracle-java8-set-default

# Add user:group (elasticsearch:elasticsearch) with preset uid:guid ($ES_UID:$ES_GID)
RUN \
  addgroup --quiet \
	   --gid ${ES_GID} \
	   elasticsearch && \
  useradd  --uid ${ES_UID} \
	   --gid elasticsearch \
	   --shell /bin/false \
	   elasticsearch

# Install elasticsearch
RUN apt-get install -y --force-yes elasticsearch=${ES_VERSION}

## Install plugins
COPY files/* /tmp/

RUN if [ ! -z "${ROR_PLUGIN}" ]; then /usr/share/elasticsearch/bin/elasticsearch-plugin install file://tmp/${ROR_PLUGIN} --batch; fi
RUN if [ ! -z "${ODA_PLUGIN}" ]; then /usr/share/elasticsearch/bin/elasticsearch-plugin install file://tmp/${ODA_PLUGIN} --batch; fi
RUN if [ ! -z "${SQL_PLUGIN}" ]; then /usr/share/elasticsearch/bin/elasticsearch-plugin install file://tmp/${SQL_PLUGIN} --batch; \
  curl -sL https://deb.nodesource.com/setup_8.x | bash; apt-get install -y --force-yes nodejs;\
  mkdir -p /opt/es-sqlui; cd /opt/es-sqlui;\
  wget https://github.com/NLPchina/elasticsearch-sql/releases/download/5.4.1.0/es-sql-site-standalone.zip;\
  unzip es-sql-site-standalone.zip;\
  cd site-server;\
  npm install express --save; fi

# Cleanup

RUN apt-get clean all && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Prepare data directories for elasticsearch
RUN mkdir -p /DATA1 /DATA2 /DATA3 /DATA4
RUN chown elasticsearch:elasticsearch /DATA1; \
    chown elastcisearch:elasticsearch /DATA2; \
    chown elastcisearch:elasticsearch /DATA3; \
    chown elastcisearch:elasticsearch /DATA4; 
RUN mkdir-p /etc/elasticsearch/scripts
RUN mkdir -p /DATA1/elasticsearch /DATA1/elasticsearch/logs

# Bootstrap
ADD files/bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh && chmod 700 /etc/bootstrap.sh

CMD ["/etc/bootstrap.sh", "-d"]

EXPOSE 9200
EXPOSE 9300

