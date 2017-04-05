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
RUN apt-get update && apt-get install -y apache2 libapache2-mod-php && \
        rm -rf /var/lib/apt/lists/*

RUN a2dismod status
RUN a2enmod ssl rewrite php
WORKDIR /var/www/html
COPY index.php /var/www/html/
EXPOSE 80
# Start the service
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/apache2ctl"]
