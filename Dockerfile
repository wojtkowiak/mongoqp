#Get Php 
FROM php:7.1.1

#Install composer php and mongodb
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 \
  && apt-get update \ 
  && apt-get install -y libssl-dev unzip \
  && pecl install mongodb \
  && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  && docker-php-ext-enable mongodb \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD ./ /mongoqp

#copy all configs to docker container
COPY config.php /mongoqp/src/config.php

RUN cd /mongoqp && \
    composer create-project

#Entry point for web
ENTRYPOINT ["php", "-S", "0.0.0.0:8080", "-t", "/mongoqp/web"]
