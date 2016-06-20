FROM debian:latest
MAINTAINER Jarkko Laaksonen <jarkkola@gmail.com>
COPY phonebook.sql /tmp/
RUN apt-get update && apt-get install -y \
    locales
RUN locale-gen --purge en_US.UTF-8
RUN apt-get install -y \
    ruby-sinatra \
    ruby-pg \
    postgresql
RUN adduser --disabled-password phonebook && adduser phonebook postgres
RUN /etc/init.d/postgresql start && su postgres -c 'createuser -d phonebook' && su phonebook -c 'createdb -E UTF8 phonebook -T template0' && su phonebook -c 'psql phonebook < /tmp/phonebook.sql' && /etc/init.d/postgresql stop
COPY src/*.rb  /usr/lib/phonebook/
COPY public/ /usr/lib/phonebook/public/
COPY startphonebook.sh /usr/lib/phonebook/
EXPOSE 80
ENTRYPOINT /usr/lib/phonebook/startphonebook.sh
