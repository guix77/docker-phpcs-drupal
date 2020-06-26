FROM php:7.3-cli-alpine
ENV PATH=${PATH}:/root/.composer/vendor/bin
RUN apk add --no-cache \
		                   git \
 && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
 && composer global require drupal/coder squizlabs/php_codesniffer \
 && phpcs --config-set installed_paths /home/app/.composer/vendor/drupal/coder/coder_sniffer/ \
 && phpcs --config-set default_standard Drupal,DrupalPractice
WORKDIR /app
ENTRYPOINT ["phpcs"]
CMD ["--version"]
