# Phonebook Application

This repository contains simple api to handle contact information.

## Development Requirements
Development environment does not install those and those can be installed from any sourve which makes them publicly available. Docker creation will install and configure those automatically to docker container.

- `postgresql` - data of the application is stored in PostgreSQL database
- `ruby` - web server uses ruby
- `ruby-pq` - web server database integration
- `ruby-sinatra` - web server engine

## Development
There is three scripts to run server locally. Development version of the
server will bind it to address **0.0.0.0:4567**. Scripts are the following:

- `initdb.sh` this script will create **phonebook** database and delete phonebook application related tables if they exists and create new tables.
- `runserver.sh` this script will start server with **development** settings
- `cleanstart.sh` this script will run both of the above scripts. Effect is that it will start clean instance of phonebook server.

## Production & Docker
Application is meant to be run in production using Docker container named `phonebook`. There is `docker` directory which contains all needed files to create Docker package. Docker package itself can be made using `make` command without parameter. In production Phonebook will also need user named `phonebook`, because it tries to change user after it has been started as `root` to bind lower ports (default 80).

Docker container has entrypoint which starts Phonebook program and all needed services. Server runs in Docker container in port 80 and it is also exposed to outer world.

## Web Interface
Web client can be accessed using url **http://server_address/**. Add person
button opens add person dialog, where first and last names and
arbitrary phone numbers can be added. Main view lists all contacts and it can be filtered using search functionality. Currently there is two supported search terms
`firstname` and `lastname`. Example all persons whose last name starts with letter 'P' can be found using search criteria `lastname=P*`. Character `*` can be used as wildcard and multiple search terms can be concatenated using character `;`. Example all persons whose first name starts with 'A' and last name with 'P' can be found using: `firstname=A*;lastname=P*`. Search functionality is case sensitive.

## Todo
- Possibility to edit/remove contact.
- Images to persons.
- Support to multiple phonebooks.
- Login/user rights to keep phonebooks private.
- Improved search criterias.
