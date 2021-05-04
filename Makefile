VERSION := 0.0.1
NAME := linguistic-annotation

build:
	docker build -f dockerfiles/Dockerfile.cpu -t ${NAME}:${VERSION} .

run-jupyter: build
	docker run --rm -it -p 8888:8888 \
	--env PYTHONPATH=/home/jovyan/work/src --env JUPYTER_ENABLE_LAB=yes --env RESTARTABLE=yes \
	--mount type=bind,source=${PWD},target=/home/jovyan/work --name ${NAME} \
	--workdir=/home/jovyan/work ${NAME}:${VERSION}

run-all:
	docker-compose up

fix-permissions:
	sudo chown -R 1000:1000 .