#!/bin/sh
trap "echo TRAPed signal" HUP INT QUIT TERM
/etc/init.d/postgresql start
RACK_ENV="production"
export RACK_ENV
cd /usr/lib/phonebook/ &&  ruby server.rb

echo "[hit enter key to exit] or run 'docker stop <container>'"
read

echo "stopping postgres"
/etc/init.d/postgresql stop

echo "exited $0"
