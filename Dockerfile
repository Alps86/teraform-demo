FROM localhost:5000/composer-base:latest as vendor
FROM mbodenhamer/alpine-data

RUN adduser -D www-data;                         \
    chgrp -R www-data /usr/local;                \
    find /usr/local -type d | xargs chmod g+w;

USER www-data

WORKDIR /code
COPY --from=vendor --chown=www-data:www-data /code .
VOLUME /code
