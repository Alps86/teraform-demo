FROM localhost:5000/composer-base:latest as vendor

#FROM ubuntu:latest
#FROM mmussomele/sleep
FROM mbodenhamer/alpine-data

RUN adduser -D www-data;                         \
    chgrp -R www-data /usr/local;                \
    find /usr/local -type d | xargs chmod g+w;

USER www-data

WORKDIR /code
COPY --from=vendor --chown=www-data:www-data /code .
#COPY --from=vendor /code/public /public
#COPY --from=vendor /code .
#ENTRYPOINT ["/bin/true"]
#CMD ["/bin/true"]

VOLUME /code
#VOLUME /public
