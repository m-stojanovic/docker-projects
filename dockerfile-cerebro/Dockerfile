FROM java:latest

ENV CEREBRO_VERSION 0.9

ADD https://github.com/lmenezes/cerebro/releases/download/v${CEREBRO_VERSION}/cerebro-${CEREBRO_VERSION}.tgz /opt/
RUN tar zxvf /opt/cerebro-${CEREBRO_VERSION}.tgz -C /opt && \
    mv /opt/cerebro-${CEREBRO_VERSION} /opt/cerebro && \
    mkdir /opt/cerebro/logs

# Remove logback file appender
RUN sed -i '/<appender-ref ref="FILE"\/>/d' /opt/cerebro/conf/logback.xml

WORKDIR /opt/cerebro
EXPOSE 8080
ENTRYPOINT ["./bin/cerebro", "-Dhttp.port=8080"]
