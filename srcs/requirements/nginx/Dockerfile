FROM debian:buster

ARG DOMAIN
ARG CERTS_

ENV DOMAIN=$DOMAIN
ENV CERTS_=$CERTS_


RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install nginx -y && apt-get instal openssl -y

COPY /tools/ /

RUN chmod +x /build.sh
RUN /build.sh

CMD ["nginx", "-g", "daemon off;"]