#!/bin/sh

exec >> /var/log/entrypoint.log
exec 2>&1

#service squid start
/usr/local/squid/sbin/squid --foreground -d 0

tail -f /dev/null
