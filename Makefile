# Color
RED		:= $(shell printf "\033[31m")
GREEN	:= $(shell printf "\033[32m")
YELLOW	:= $(shell printf "\033[33m")
BLUE	:= $(shell printf "\033[34m")
BOLD	:= $(shell printf "\033[1m")
RESET	:= $(shell printf "\033[m")

DOCKER_COMPOSE ?= docker-compose

.PHONY: help
help: # Provides help information on available commands
	@printf "Usage: make COMMAND\n\n"
	@printf "Commands:\n"
	@awk -F ':(.*)## ' '/^[a-zA-Z0-9%\\\/_.-]+:(.*)##/ { \
	 printf "  \033[36m%-20s\033[0m %s\n", $$1, $$NF \
	}' $(MAKEFILE_LIST)

.PHONY: build
build: ## Build all Docker images of the project
	@$(DOCKER_COMPOSE) build

.PHONY: up
up: ## Builds and start all containers (in the background)
	@$(DOCKER_COMPOSE) up -d
	@make urls

.PHONY: down
down: ## Stops and deletes containers and networks created by "up".
	@$(DOCKER_COMPOSE) down

.PHONY: restart
restart: down up ## Restarts all containers

.PHONY: purge
purge: ## Stops and deletes containers, volumes, images and networks created by "up".
	@$(DOCKER_COMPOSE) down -v --rmi all

.PHONY: rebuild
rebuild: down build up ## Rebuild all the project

.PHONY: rebuild/back
rebuild/back: ## Rebuild the back project
	@$(DOCKER_COMPOSE) build go
	@make up

.PHONY: rebuild/front
rebuild/front: ## Rebuild the front project
	@$(DOCKER_COMPOSE) build nginx
	@make up

.PHONY: urls
urls: ## Get project's URL
	@echo "\n\n"
	@echo " _______  __      .___  ___. .______    __    __  .___  ___."
	@echo "|   ____||  |     |   \/   | |   _  \  |  |  |  | |   \/   |"
	@echo "|  |__   |  |     |  \  /  | |  |_)  | |  |  |  | |  \  /  |"
	@echo "|   __|  |  |     |  |\/|  | |   _  <  |  |  |  | |  |\/|  |"
	@echo "|  |____ |  \`----.|  |  |  | |  |_)  | |  \`--'  | |  |  |  |"
	@echo "|_______||_______||__|  |__| |______/   \______/  |__|  |__|"
	@echo "\n        Alexis Cauchois | Axel Rayer | Hugo Tinghino        "
	@echo "\n"
	@echo "------------------------------------------------------------"
	@echo "${GREEN}You can access your project at the following URLS:${RESET}"
	@echo "------------------------------------------------------------"
	@$(DOCKER_COMPOSE) ps -q | xargs -n1 -I ID sh -c 'docker inspect --format="{{.Config.Image}}" ID ; docker port ID' | xargs -n4 printf '%-30s: %s %s %s\n' | sed "s/0.0.0.0/http:\/\/localhost/"

.PHONY: lint/go
lint/go: ## Run golangci-lint (All-In-One config)
	@docker run --rm --volume ${PWD}/back:/app -w /app golangci/golangci-lint golangci-lint run --out-format tab --enable-all --exclude-use-default=false | \
	awk -F '[[:space:]][[:space:]]+' '{ \
		split($$1, fileInfo, ":") ; \
		dottingLenght = 80 ; \
		dotting = sprintf("%*s", dottingLenght, ""); gsub(/ /, "- ", dotting) ; \
		printf "\n\n\033[36m- - %s %0.*s %s\033[m", toupper($$2), dottingLenght-length($$1)-length($$2), dotting, fileInfo[1] ; \
		printf "\n\n\033[1mLine %s, Column %s", fileInfo[2], fileInfo[3] ; \
		printf "\n\n\033[1m%s\n\n", $$3 ; \
		system(sprintf("printf \"\033[33m%s| \033[m\" && sed -n %sp ./back/%s | sed -e \"s/\t/ /g\"", fileInfo[2], fileInfo[2], fileInfo[1])) ; \
		printf "\033[31m\033[1m%*s\033[m\n", fileInfo[3]+length(fileInfo[2])+2, "^" ; \
	} END { printf "\033[31m%s errors detected", NR	}'