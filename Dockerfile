#Get Php 
FROM php:7.1.1

#Install composer php and mongodb
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 \
  && echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.2 main" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list \
  && apt-get update \ 
  && apt-get install -y mongodb-org --no-install-recommends \
  && apt-get install -y libssl-dev unzip \
  && pecl install mongodb \
  && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  && docker-php-ext-enable mongodb \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#create project using composer   
RUN composer create-project jmikola/mongoqp

#copy all configs to docker container 
COPY config.php /mongoqp/src/config.php

#Entry point for web
ENTRYPOINT ["php", "-S", "0.0.0.0:8080", "-t", "web"]
