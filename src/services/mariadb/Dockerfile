FROM debian:buster

EXPOSE 3306

RUN apt-get -y update && apt-get -y upgrade && apt-get install -y mariadb-server

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/mariadb.sh /mariadb.sh

ENTRYPOINT ["bash", "mariadb.sh"]
