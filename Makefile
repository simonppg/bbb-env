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
	if [ ! -d ${HOME}/bbb-hal/buildroot ]; then\
		git clone git://git.busybox.net/buildroot;\
		cd buildroot && git checkout 2016.05;\
	else\
		cd buildroot && git checkout 2016.05;\
	fi

build_docker_image: Dockerfile
	docker build -t dev-env .

run_docker_image: build_docker_image fetch
	docker run -v ${HOME}/bbb-hal:/home/bone/bbb-hal -it dev-env

clean_docker_containers:
	docker rm -f `docker ps -a -q`

clean_docker_images:
	docker rmi -f `docker images -a -q`
