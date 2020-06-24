.PHONY: default
default:
	echo default target

.PHONY: build
build:
	sudo docker build -t squid .

.PHONY: start
start:
	sudo docker run -d -p 3128:3128 -p 3129:3129 --name squid squid

.PHONY: connect
connect:
	sudo docker exec -it squid /bin/bash

.PHONY: stop
stop:
	sudo docker stop squid

.PHONY: rm
rm: stop
	sudo docker rm squid
