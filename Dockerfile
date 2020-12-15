FROM openwrtorg/rootfs:19.07.3

RUN mkdir /var/lock && \
    opkg update && \
    opkg list-upgradable | cut -f 1 -d ' ' | xargs opkg upgrade && \
    opkg install uhttpd libjson-c uhttpd-mod-lua && \
    uci set uhttpd.main.interpreter='.lua=/usr/bin/lua' && \
    uci commit uhttpd && \
    rm /var/opkg-lists/*

COPY health-check.sh /sbin/

RUN chmod +x /sbin/health-check.sh

HEALTHCHECK --interval=5s \
            --timeout=3s \
            --start-period=3s \
            --retries=1 CMD "/health-check.sh"

COPY config/* /etc/config/

EXPOSE 80 22 443

ENTRYPOINT [ "/sbin/init" ]
