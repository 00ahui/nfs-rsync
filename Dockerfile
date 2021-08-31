FROM alpine

COPY nfs-rsync.sh /usr/bin/nfs-rsync.sh

RUN apk add --no-cache nfs-utils rsync && \
    chmod +x /usr/bin/nfs-rsync.sh && \
    mkdir /target

ENTRYPOINT ["/usr/bin/nfs-rsync.sh"]
