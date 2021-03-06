docker-devel: clean
	mkdir -p docker/src
	cp *.rb docker/src/
	cp -R public/ docker/public/
	cp phonebook.sql docker/
	cd docker && docker build -t phonebook .

clean:
	rm -rf docker/src
	rm -rf docker/html
