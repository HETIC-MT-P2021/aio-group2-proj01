# Welcome to ElmBum 👋
![Version](https://img.shields.io/badge/version-1.0.0-blue.svg?cacheSeconds=2592000)
[![Documentation](https://img.shields.io/badge/documentation-yes-brightgreen.svg)](#)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](CODE_OF_CONDUCT.md)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](#)

> Web application written in Go & ELM used to manage a photo album

## Usage


Required development environment:
- [Docker](https://www.docker.com)
- [Docker Compose](https://docs.docker.com/compose/install/)

Configure the development environment on your local machine:
```bash
$ git clone https://github.com/HETIC-MT-P2021/aio-group2-proj01.git
$ cd aio-group2-proj01
$ docker-compose up -d
=======

Required development environment:
- [Docker](https://www.docker.com)
- [Docker Compose](https://docs.docker.com/compose/install/)

Configure the development environment on your local machine:
```bash
$ git clone https://github.com/HETIC-MT-P2021/aio-group2-proj01.git
$ cd aio-group2-proj01
$ make up
```

You can now access the api: [http://localhost:1323/](http://localhost:1323/).

## Use the command line

To list available commands, either run `make` with no parameters or execute `make help`:

```bash
$ make help
Usage: make COMMAND

Commands:
  build                Build all Docker images of the project
  up                   Builds and start all containers (in the background)
  down                 Stops and deletes containers and networks created by "up".
  restart              Restarts all containers
  purge                Stops and deletes containers, volumes, images and networks created by "up".
  rebuild              Rebuild all the project
  rebuild/back         Rebuild the back project
  rebuild/front        Rebuild the front project
  urls                 Get project's URL
```

You can now access the api: [http://localhost:1323/](http://localhost:1323/).

## Author

👤 **Alexis Cauchois**

👤 **Axel Rayer**

👤 **Hugo Tinghino**


## Show your support

Give a ⭐️ if this project helped you!