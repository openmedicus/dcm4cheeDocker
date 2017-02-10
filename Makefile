VERSION = 2.18.3

all: pull build tag push

pull:
	sudo docker pull centos:7

build:
	sudo docker build -t dcm4chee .

push:
	sudo docker tag dcm4chee openmedicus/dcm4chee:$(VERSION)
	sudo docker push openmedicus/dcm4chee
	sudo docker tag dcm4chee openmedicus/dcm4chee:latest
	sudo docker push openmedicus/dcm4chee

run:
	sudo docker run -i -t dcm4chee /bin/bash

download:
	firefox http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
	wget -O - http://sourceforge.net/projects/dcm4che/files/dcm4chee/$(VERSION)/dcm4chee-$(VERSION)-psql.zip/download > dcm4chee-$(VERSION)-psql.zip
