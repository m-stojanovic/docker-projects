#!/bin/bash

/etc/init.d/mysql restart

# keep process running

tail -f /var/log/mysql/mysql.log
