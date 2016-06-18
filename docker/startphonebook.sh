#!/bin/sh
trap "echo TRAPed signal" HUP INT QUIT TERM
/etc/init.d/postgresql start
cd /usr/lib/phonebook/ && su phonebook -c 'ruby server.rb'

echo "[hit enter key to exit] or run 'docker stop <container>'"
read

echo "stopping postgres"
/etc/init.d/postgresql stop

echo "exited $0"
