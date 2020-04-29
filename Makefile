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
up: build ## Builds and start all containers (in the background)
	@$(DOCKER_COMPOSE) up -d
	@make about
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

DOCKER_INPECT_FORMAT__AWK ?= "'\''{{.Name}} : {{range $$p, $$conf := .NetworkSettings.Ports}}{{$$p}} -> {{(index $$conf 0).HostIp}}:{{(index $$conf 0).HostPort}}\t{{end}}'\''"

.PHONY: urls
urls: ## Get project's URL
	@echo "------------------------------------------------------------"
	@echo "${GREEN}You can access your project at the following URLS:${RESET}"
	@echo "------------------------------------------------------------"
	@$(DOCKER_COMPOSE) ps -q | awk '{ \
		cmd_docker_inspect = sprintf("docker inspect --format=%s %s", ${DOCKER_INPECT_FORMAT__AWK}, $$0) ; \
		cmd_docker_inspect | getline docker_inspect ; close(cmd_docker_inspect) ; \
		gsub(/0.0.0.0/, "http://localhost", docker_inspect) ; \
		split(docker_inspect, urls, "\t") ; \
		printf "%s\n", urls[1] ; \
		i = 2 ; while (i <= length(urls)) { \
		index_tab = index(docker_inspect,":") ; \
		printf "%*s %*s\n", index_tab, "", index_tab, urls[i]; i++ \
		} ; \
	}'

.PHONY: about
about:
	@echo " _______  __      .___  ___. .______    __    __  .___  ___."
	@echo "|   ____||  |     |   \/   | |   _  \  |  |  |  | |   \/   |"
	@echo "|  |__   |  |     |  \  /  | |  |_)  | |  |  |  | |  \  /  |"
	@echo "|   __|  |  |     |  |\/|  | |   _  <  |  |  |  | |  |\/|  |"
	@echo "|  |____ |  \`----.|  |  |  | |  |_)  | |  \`--'  | |  |  |  |"
	@echo "|_______||_______||__|  |__| |______/   \______/  |__|  |__|"
	@echo "\n        Alexis Cauchois | Axel Rayer | Hugo Tinghino        "

.PHONY: lint/go
lint/go: ## Run golangci-lint (All-In-One config)
	@docker run --rm -v ${PWD}/back:/app -w /app golangci/golangci-lint golangci-lint run --out-format tab | \
	awk -F '[[:space:]][[:space:]]+' '{ \
		linter_name = $$2 ; \
		error_message = $$3 ; \
		split($$1, error_file_info, ":") ; \
		error_file_path = sprintf("./back/%s", error_file_info[1]) ; \
		error_line_number = error_file_info[2] ; \
		error_col_number = error_file_info[3] ; \
		\
		dashed_line_length = 80 ; \
		dashed_line = sprintf("%*s", dashed_line_length, ""); gsub(/ /, "- ", dashed_line) ; \
		\
		printf "\n\033[36m- - %s %0.*s %s\033[m", toupper(linter_name), dashed_line_length - length($$1) - length($$2), dashed_line, fileInfo[1] ; \
		printf "\n\n\033[1mLine %s, Column %s", error_line_number, error_col_number ; \
		printf "\n\n\033[1m%s", error_message ; \
		\
		cmd_read_error_line = sprintf("sed -n %sp %s | sed -e \"s/\t/ /g\"", error_line_number, error_file_path) ; \
		cmd_read_error_line | getline error_line ; close(cmd_read_error_line) ; \
		printf "\n\n\033[33m%s|\033[m %s", error_line_number, error_line ; \
		\
		printf "\n\033[31m\033[1m%*s\033[m", error_col_number + length(error_line_number) + 2, "^" ; \
	} END { printf "\n\033[31m%s errors detected\n", NR	}'
