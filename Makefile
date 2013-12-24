install:
	cd cucumber && bundle install

start-server:
	bin/yslow-data-rest-api

test:
	cd cucumber && bundle exec cucumber

PHONY: test, install, start-server