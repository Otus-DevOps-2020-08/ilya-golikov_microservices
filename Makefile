THIS_FILE := $(lastword $(MAKEFILE_LIST))
ifeq (,$(wildcard docker/.env))
    $(error docker/.env does not exist!)
endif
ifndef USER_NAME
	export USER_NAME := $(shell grep USER_NAME docker/.env | cut -d'=' -f2)
endif
build_sh := bash docker_build.sh
docker_build := docker build -t $(USER_NAME)


.PHONY: help build_ui build_comment build_post

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

------------------------------: ## ---------------------------------

all: push_ui push_comment push_post push_prometheus push_mongodb_exporter## Build all docker images and push them in docker hub

build_ui: ## Build "ui" docker image
	@echo '>> Build "ui" docker image'
	@cd src/ui/ && $(build_sh)

build_post: ## Build "post" docker image
	@echo '>> Build "post" docker image'
	@cd src/post-py/ && $(build_sh)

build_comment: ## Build "comment" docker image
	@echo '>> Build "comment" docker image'
	@cd src/comment && $(build_sh)

build_prometheus: ## Build "Prometheus" docker image
	@echo '>> Build "Prometheus" docker image'
	@cd monitoring/prometheus && $(docker_build)/prometheus .

build_mongodb_exporter: ## Build "Mongodb exporter" docker image
	@echo '>> Build "Mongodb exporter" docker image'
	@cd monitoring/mongodb_exporter && $(docker_build)/mongodb_exporter .

push_ui: build_ui ## Push ui image in docker hub
	@echo '>> Push "ui" image in docker hub'
	@docker push $(USER_NAME)/ui

push_post: build_post ## Push post image in docker hub
	@echo '>> Push "post" image in docker hub'
	@docker push $(USER_NAME)/post

push_comment: build_comment ## Push comment image in docker hub
	@echo '>> Push "comment" image in docker hub'
	@docker push $(USER_NAME)/comment

push_prometheus: build_prometheus ## Push prometheus image in docker hub
	@echo '>> Push "prometheus" image in docker hub'
	@docker push $(USER_NAME)/prometheus

push_mongodb_exporter: build_mongodb_exporter ## Push mongodb_exporter image in docker hub
	@echo '>> Push "mongodb_exporter" image in docker hub'
	@docker push $(USER_NAME)/mongodb_exporter

------------------------------: ## ---------------------------------

up: ## Create and up containers described in docker/docker-compose.yml
	@echo '>> Creating and start containers...'
	@cd docker && docker-compose up -d

down: ## Stop and remove containers and networks
	@echo '>> Stop and remove containers and networks...'
	@cd docker && docker-compose down

destroy: ## Stop and remove containers, networks and named volumes declared in the the Compose file
	@echo '>> Destroy containers, networks and volumes... '
	@cd docker && docker-compose down -v

stop: ## Stop services
	@echo '>> Stopping containers...'
	@cd docker && docker-compose -f docker-compose.yml stop

restart: ## Restart services
	@echo '>> Restarting containers...'
	@cd docker && docker-compose -f docker-compose.yml restart

kill: ## Kill all running containers
	@echo '>> Killing all running containers'
	@docker kill $(shell docker ps -q) 2> /dev/null; true

clean: ## Remove all
	@echo '>> Kill running containers...'
	@docker kill $(shell docker ps -q) 2> /dev/null; true
	@echo '>> Remove all containers...'
	@docker container rm $(shell docker container ls -a -q) 2> /dev/null; true
	@echo '>> Remove all images...'
	@docker rmi $(shell docker images -q) 2> /dev/null; true
	@echo '>> Remove all networks...'
	@docker network rm $(shell docker network ls -q) 2> /dev/null; true
	@echo '>> Remove all volumes...'
	@docker volume rm $(shell docker volume ls -q) 2> /dev/null; true
