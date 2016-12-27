all: help

help:
	@echo "usage:"
	@echo "make target"
	@echo "targets:"
	@echo "		build_docker_image"
	@echo "		run_docker_image"
	@echo "		clean_docker_containers"
	@echo "		clean_docker_images"

fetch:
	if [ ! -d ${HOME}/buildroot ]; then\
		git clone git://git.busybox.net/buildroot;\
		cd ${HOME}/buildroot && git checkout 2016.05;\
	else\
		cd ${HOME}/buildroot && git checkout 2016.05;\
	fi

build_docker_image: Dockerfile
	docker build -t dev-env .

run_docker_image: build_docker_image fetch
	docker run --rm \
		-v ${HOME}/bbb-hal:/home/bone/bbb-hal \
		-v ${HOME}/buildroot:/home/bone/bbb-hal/buildroot -it dev-env

clean_docker_containers:
	docker rm -f `docker ps -a -q`

build_bbb_linux_image:
	cp -l -f ${HOME}/bbb-hal/configs/bbb_defconfig ${HOME}/bbb-hal/buildroot/configs/bbb_defconfig;\
	cd buildroot && make bbb_defconfig && make;

clean_docker_images:
	docker rmi -f `docker images -a -q`
