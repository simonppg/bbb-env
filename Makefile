all: help

help:
	@echo "usage:"
	@echo "make target"
	@echo "targets: build_docker_image run_docker_image"

build_docker_image: Dockerfile
	docker build -t dev-env .

run_docker_image:
	docker run -it dev-env
