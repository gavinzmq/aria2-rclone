FROM alpine:3.4

COPY aria2 /root/.aria2
COPY init.sh /root/init.sh

RUN apk add --update --no-cache aria2 wget \
    && wget -O rclone.zip  https://downloads.rclone.org/rclone-current-linux-amd64.zip --no-check-certificate \
    && unzip rclone.zip -d . \
    && mv rclone-*-linux-*/rclone /usr/bin \
    && rm rclone-*-linux-* -rf \
    && rm rclone.zip \
    && apk del unzip wget \
    && rm -rf /var/cache/apk/*

VOLUME ["/root/.aria2","/root/Download", "/config"]
EXPOSE 6800

ENTRYPOINT [ "/root/init.sh" ]