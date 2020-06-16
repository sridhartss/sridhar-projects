FROM alpine
ADD crontab.txt /crontab.txt
ADD script.sh /script.sh
COPY entry.sh /entry.sh
RUN chmod 755 /script.sh /entry.sh
RUN /usr/bin/crontab /crontab.txt
RUN apk update && apk add mysql-client && rm -f /var/cache/apk/* && apk add curl && apk add jq
