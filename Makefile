#
#	Makefile
#	to build image easier
#

IMAGE_NAME=slocomptech/openvpn
DATA_DIR=$(shell pwd)/data
CONTAINER_NAME=ovpn


default: build

#
#	Build docker image
#
build:
	@echo "Building image"
	docker build \
		--build-arg BUILD_DATE=$(shell date -u +\"%Y-%m-%dT%H:%M:%SZ\") \
		--build-arg VCS_REF="$(shell git rev-parse --short HEAD)" \
		--build-arg VCS_SRC="https://github.com/SloCompTech/docker-openvpn/commit/$(shell git rev-parse HEAD)" \
		--build-arg VERSION=latest \
		-t ${IMAGE_NAME} .

#
#	Run setup command
#	Opens temporary container to setup environment
#
config:
	@echo "Running temporary container"
	mkdir -p data
	docker run -it --rm --cap-add NET_ADMIN -v ${DATA_DIR}:/config ${IMAGE_NAME}:latest bash

#
#	Setups & starts real container
#	Run only once, then use docker start|stop|restart|exec
#
setup:
	@echo "Running temporary container"
	docker run -it --cap-add NET_ADMIN -p 1194:1194/udp -v ${DATA_DIR}:/config --name ${CONTAINER_NAME} ${IMAGE_NAME}:latest 

#
#	Starts container
#
start:
	docker start ${CONTAINER_NAME}

#
#	Stops container
#
stop:
	docker stop ${CONTAINER_NAME}

#
#	Restart container
#
restart:
	docker restart ${CONTAINER_NAME}

#
#	Open terminal inside container
#	Only when container is running
#
term:
	docker exec -it ${CONTAINER_NAME} bash