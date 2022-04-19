DOKUWIKI_VERSION := 2018-04-22b

all: build

download:
	mkdir -p .cache	
	curl https://download.dokuwiki.org/src/dokuwiki/dokuwiki-${DOKUWIKI_VERSION}.tgz -o .cache/dokuwiki-${DOKUWIKI_VERSION}.tgz
	md5sum .cache/dokuwiki-${DOKUWIKI_VERSION}.tgz -c download.md5sum

build:
	mkdir -p data
	tar xzf .cache/dokuwiki-${DOKUWIKI_VERSION}.tgz -C data --strip-components 1
	bash patches/00/run.sh
	bash patches/01/run.sh
	bash patches/02/run.sh
	bash patches/03/run.sh
	bash patches/04/run.sh

clean:
	rm -rf data

.PHONEY: download build
