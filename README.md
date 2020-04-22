<table width="100%">
	<tr>
		<td align="left" width="70">
			<strong>ElmBum</strong><br />
			Web application written in Go & ELM used to manage a photo album
		</td>
		<td align="right" width="20%">
			<a href="https://goreportcard.com/report/github.com/HETIC-MT-P2021/aio-group2-proj01">
				<img src="https://goreportcard.com/badge/github.com/HETIC-MT-P2021/aio-group2-proj01" alt="Go Report Card">
			</a>
      <a href="https://github.com/HETIC-MT-P2021/aio-group2-proj01/blob/master/LICENSE">
			  <img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT"/>
      </a>
		</td>
	</tr>
	<tr>
		<td>
			A Hetic student project.
		</td>
		<td align="center">
			<img src="https://user-images.githubusercontent.com/27848278/80025966-ab059800-84e1-11ea-9e37-41a3ddcbda89.png" width="100"/>
		</td>
	</tr>
</table>

## Usage

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

<p align="center" style="margin: 40px 0">
  <img src="https://user-images.githubusercontent.com/27848278/80033563-3cc6d280-84ed-11ea-8721-94331b52e23b.gif" style="max-width: 80%;">
</p>

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

## Author

<table>
  <tr>
    <td align="center">
      <a href="https://github.com/acauchois">
        <img src="https://github.com/acauchois.png" width="150px;"/><br>
        <b>Alexis Cauchois</b>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/Akecel">
        <img src="https://github.com/Akecel.png" width="150px;"/><br>
        <b>Axel Rayer</b>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/t-hugo">
        <img src="https://github.com/t-hugo.png" width="150px;"/><br>
        <b>Hugo Tinghino</b>
      </a>
    </td>
  </tr>
</table>
