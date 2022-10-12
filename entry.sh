#!/bin/sh

# configure crontab based on the existance of the LOGENTRIES_KEY environment variable
if [ "$LOGENTRIES_KEY" ]; then
  cp /crontab-syslog.txt /etc/crontabs/root
  sed -i /etc/rsyslog.conf -e "s/LOGENTRIESKEY/${LOGENTRIES_KEY}/"
  rsyslogd
  sleep 10  # ensure rsyslogd is running before we may need to send logs to it
else
  cp /crontab.txt /etc/crontabs/root
fi

# setup env
echo "[default]"                              > /root/.s3cfg
echo "access_key = ${ACCESS_KEY}"     >> /root/.s3cfg
echo "access_token = ${SECRET_KEY}" >> /root/.s3cfg
echo "bucket_location = ${BUCKET_LOCATION}" >> /root/.s3cfg
echo "host_base = ${ENDPOINT_URL}" >> /root/.s3cfg

python3 /run.py

# start cron
crond -f
