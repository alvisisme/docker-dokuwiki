all: build

build:
	tar czf dokuwiki.tar.gz -C dokuwiki .
	docker-compose build

.PHONEY: build