FROM debian:buster

EXPOSE 443

RUN apt-get -y update && apt-get -y upgrade && apt-get install -y nginx

RUN mkdir -p /etc/nginx/ssl && apt-get install -y openssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=rben-tkh.42.fr/UID=rben-tkh"

RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/wordpress && chmod 755 /var/www/wordpress

RUN chown -R www-data:www-data /var/www/wordpress

CMD [ "nginx", "-g", "daemon off;" ]
