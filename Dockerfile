FROM debian:jessie
MAINTAINER javier@melic.es
RUN apt-get update && apt-get install -y \
                $PHPIZE_DEPS \
                ca-certificates \
                curl \
                libedit2 \
                libsqlite3-0 \
                libxml2 \
                xz-utils \
                --no-install-recommends && rm -r /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y apache2 && \
        rm -rf /var/lib/apt/lists/*

RUN a2dismod status
RUN a2enmod ssl rewrite
WORKDIR /var/www/html
COPY index.php /var/www/html/
EXPOSE 80
CMD ["/usr/sbin/apache2ctl start"]
