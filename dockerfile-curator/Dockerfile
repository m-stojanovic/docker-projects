FROM python:3.6-alpine

ARG CURATOR_VERSION=5.8.1

# Install curator
RUN pip install elasticsearch-curator==${CURATOR_VERSION} &&\
    rm -rf /var/cache/apk/*

# Prepare config files
COPY ./config /config

# Add cron jobs to crontab
RUN /usr/bin/crontab /config/crontab.txt

CMD ["/usr/sbin/crond","-f"]
