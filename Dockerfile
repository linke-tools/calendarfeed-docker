FROM debian:latest

RUN apt-get update && apt-get -y install ca-certificates curl git gettext mariadb-client
RUN curl --proto '=https' --tlsv1.2 -sSf  https://packages.sury.org/php/README.txt | bash && apt-get -y install php8.4-fpm php8.4-xml php8.4-curl php8.4-mysql
RUN useradd -d /calendarfeed -k /dev/null -m -s /bin/bash calendarfeed
COPY files/php-fpm.conf /etc/php/8.4/fpm/pool.d/www.conf

USER calendarfeed
RUN cd && git clone https://github.com/linke-tools/calendarfeed.git calendarfeed

COPY files/entrypoint.sh /entrypoint.sh

USER root


EXPOSE 9000
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/php-fpm8.4","--nodaemonize","--fpm-config","/etc/php/8.4/fpm/php-fpm.conf"]

