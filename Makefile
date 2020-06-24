DOCKER_MACHINE_NAME=docker-host
SRC_FOLDER=src
MONGODB_EXPORTER_VERSION=v0.11.0

docker_machine_create:
	docker-machine create --driver google \
	--google-machine-image https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts \
	--google-machine-type \
	n1-standard-1 \
	--google-zone \
	europe-west1-b \
	${DOCKER_MACHINE_NAME}

docker_machine_delete:
	docker-machine rm ${DOCKER_MACHINE_NAME}

docker_build_ui:
	cd ${SRC_FOLDER}/ui && bash ./docker_build.sh

docker_build_post-py:
	cd ${SRC_FOLDER}/post-py && bash ./docker_build.sh

docker_build_comment:
	cd ${SRC_FOLDER}/comment && bash ./docker_build.sh

docker_build_prometheus:
	cd ./monitoring/prometheus && docker build -t $${USER_NAME}/prometheus .

docker_clone_mongodb_exporter:
	test -d "./monitoring/mongodb_exporter" || (cd ./monitoring && git clone https://github.com/percona/mongodb_exporter.git)

docker_build_mongodb_exporter: docker_clone_mongodb_exporter
	cd ./monitoring/mongodb_exporter && \
	make docker DOCKER_IMAGE_NAME=$${USER_NAME}/mongodb-exporter DOCKER_IMAGE_TAG=${MONGODB_EXPORTER_VERSION}

docker_build_blackbox_exporter:
	docker build -t $${USER_NAME}/blackbox-exporter:latest 'https://github.com/bitnami/bitnami-docker-blackbox-exporter.git#master:0/debian-10'

docker_build_alertmanager:
	cd ./monitoring/alertmanager && docker build -t $${USER_NAME}/alertmanager .

docker_build_all: docker_build_ui docker_build_post-py docker_build_comment docker_build_prometheus docker_build_mongodb_exporter docker_build_blackbox_exporter docker_build_alertmanager

docker_push_ui:
	docker push $${USER_NAME}/ui

docker_push_comment:
	docker push $${USER_NAME}/comment

docker_push_post:
	docker push $${USER_NAME}/post

docker_push_prometheus:
	docker push $${USER_NAME}/prometheus

docker_push_mongodb_exporter:
	docker push $${USER_NAME}/mongodb-exporter:${MONGODB_EXPORTER_VERSION}

docker_push_blackbox_exporter:
	docker push $${USER_NAME}/blackbox-exporter:latest

docker_push_alertmanager:
	docker push $${USER_NAME}/alertmanager

docker_push_all: docker_push_ui docker_push_comment docker_push_post docker_push_prometheus docker_push_mongodb_exporter docker_push_blackbox_exporter docker_push_alertmanager

compose_up_app:
	docker-compose -f docker/docker-compose.yml up -d

compose_down_app:
	docker-compose -f docker/docker-compose.yml down

compose_up_monitoring:
	docker-compose -f docker/docker-compose-monitoring.yml up -d

compose_down_monitoring:
	docker-compose -f docker/docker-compose-monitoring.yml down

compose_up_all: compose_up_app compose_up_monitoring

compose_down_all: compose_down_app compose_down_monitoring
