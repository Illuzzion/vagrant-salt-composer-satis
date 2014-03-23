composer:
  cmd.run:
    - name: 'CURL=`which curl`; $CURL -sS https://getcomposer.org/installer | php && mv /root/composer.phar /usr/local/bin/composer'
    - unless: test -f /usr/local/bin/composer
    - cwd: /root/
    - require:
      - pkg: php

{# The global composer config -- will have your github auth token so Satic can make more than 60 requests per hour #}
composer-config:
  file:
    - managed
    - name: /root/.composer/config.json
    - template: jinja
    - user: root
    - group: root
    - mode: 440
    - source: salt://files/composer-global
    - require:
      - cmd: composer
