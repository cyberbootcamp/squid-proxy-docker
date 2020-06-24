FROM ubuntu:latest
LABEL maintainer="korben@kirscht.com"

ENV SQUID_VERSION=3.5.27 \
    SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=proxy

COPY squid-4.12.tar.gz /tmp/.
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -yq libtool-bin autoconf ed gcc make g++
# && rm -rf /var/lib/apt/lists/* # && \
# mkdir /var/spool/squid3 && chown proxy:proxy /var/spool/squid3 && squid -z

# openssl req -new -newkey rsa:2048 -sha256 -days 365 -nodes -x509 -extensions v3_ca -keyout squid-ca-key.pem -out squid-ca-cert.pem
# cat squid-ca-cert.pem squid-ca-key.pem >> squid-ca-cert-key.pem

#RUN mkdir -p /etc/squid/certs
#COPY squid-ca-cert-key.pem /etc/squid/certs 

RUN cd /tmp/ && tar xf squid-4.12.tar.gz && cd squid-4.12 && ./configure --prefix=/usr/local/squid && \
	make all && make install && chmod -R 0777 /usr/local/squid/



COPY bin/entrypoint.sh /bin/entrypoint.sh
COPY etc/ etc/
RUN chmod 755 /bin/entrypoint.sh

EXPOSE 3128/tcp
#EXPOSE 3129/tcp
ENTRYPOINT ["/bin/entrypoint.sh"]
#FROM alpine:3.7
#RUN apk add --no-cache squid
#ENTRYPOINT ["tail -f /dev/null"]
