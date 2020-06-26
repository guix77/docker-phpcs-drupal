FROM php:7.3-cli-alpine
RUN apk add --no-cache \
		                   git \
 && addgroup -g 1000 app \
 && adduser -D -u 1000 -G app app \
 && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

USER app
ENV PATH=${PATH}:/home/app/.composer/vendor/bin
RUN mkdir ~/.composer \
 && echo "{}" > ~/.composer/composer.json \
 && composer global require drupal/coder squizlabs/php_codesniffer \
 && phpcs --config-set installed_paths /home/app/.composer/vendor/drupal/coder/coder_sniffer/ \
 && phpcs --config-set default_standard Drupal,DrupalPractice
WORKDIR /app
ENTRYPOINT ["phpcs"]
CMD ["--version"]
