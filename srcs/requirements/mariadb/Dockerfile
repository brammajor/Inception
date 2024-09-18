FROM debian:buster

ARG DB_NAME
ARG ADM_USER
ARG ADM_PASS
ARG ROOT_PASS

ENV DB_NAME=$DB_NAME
ENV ADM_USER=$ADM_USER
ENV ADM_PASS=$ADM_PASS
ENV ROOT_PASS=$ROOT_PASS

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install mariadb-server -y

COPY /conf/50-sever.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY /tools/startup.sh /startup.sh

RUN chmod +x /startup.sh

CMD [ "/startup.sh"]