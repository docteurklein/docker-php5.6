FROM busybox
ADD files/php /opt/php/5.6
ADD files/usr/lib /usr/lib
ADD files/lib64 /lib64
WORKDIR /opt/php/5.6
ENTRYPOINT ["/opt/php/5.6/bin/php"]
CMD ["-a"]
