FROM alpine:3.16

RUN apk update \
    && apk add --update --no-cache python3 py-pip rsyslog rsyslog-tls ca-certificates openssl \
    && python3 -m ensurepip \
    && pip3 install --no-cache --upgrade pip awscli

COPY run.py /run.py
COPY crontab.txt /crontab.txt
COPY crontab-syslog.txt /crontab-syslog.txt
COPY rsyslog.conf /etc/rsyslog.conf
COPY entry.sh /entry.sh

RUN chmod 755 /entry.sh

USER 1000:1000

CMD ["/entry.sh"]
