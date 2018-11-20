SHELL:=/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

all: help

help:
	@echo ""
	@echo "usage:"
	@echo "make target"
	@echo ""
	@echo "host_targets:"
	@echo "    build_docker_image"
	@echo "    run_docker_container"
	@echo "    clean_docker_containers"
	@echo "    clean_docker_images"
	@echo ""
	@echo "container_targets:"
	@echo "    build_bbb_linux"
	@echo ""

build_bbb_linux:
	whoami
	cp -v configs/bbb_defconfig buildroot/configs
	cd buildroot; make bbb_defconfig; make;

fetch:
	if [ ! -d ${HOME}/buildroot ]; then\
		git clone git://git.busybox.net/buildroot ${HOME}/buildroot;\
		cd ${HOME}/buildroot && git checkout 2016.05;\
	else\
		cd ${HOME}/buildroot && git checkout 2016.05;\
	fi

build_docker_image: Dockerfile
	docker build -t dev-env .

run_docker_container: build_docker_image fetch
	docker run --rm \
		-v ${HOME}/bbb-hal:/home/bone/bbb-hal \
		-v ${HOME}/buildroot:/home/bone/bbb-hal/buildroot -it dev-env

clean_docker_containers:
	if [[ -z `docker ps -a -q` ]]; then\
		printf "${RED}container list is empty${NC}";\
	else\
		printf "${GREEN}cleanning containers:${NC}";\
		docker rm -f `docker ps -a -q`;\
	fi

build_bbb_linux_image:
	cp -l -f ${HOME}/bbb-hal/configs/bbb_defconfig ${HOME}/bbb-hal/buildroot/configs/bbb_defconfig;\
	cd buildroot && make bbb_defconfig && make;

clean_docker_images:
	if [[ -z `docker images -a -q` ]]; then\
		printf "${RED}images list is empty${NC}";\
	else\
		printf "${GREEN}cleanning images:${NC}";\
		docker rmi -f `docker images -a -q`;\
	fi

clean:
	@make clean_docker_containers
	@make clean_docker_images
