# docker-godaddypy<br>
Godaddypy ddns for the cheap in a docker container

![Trueosiris Rules](https://img.shields.io/badge/trueosiris-rules-f08060) 
[![Docker Pulls](https://badgen.net/docker/pulls/trueosiris/godaddypy?icon=docker&label=pulls)](https://hub.docker.com/r/trueosiris/godaddypy/) 
[![Docker Stars](https://badgen.net/docker/stars/trueosiris/godaddypy?icon=docker&label=stars)](https://hub.docker.com/r/trueosiris/godaddypy/) 
[![Docker Image Size](https://badgen.net/docker/size/trueosiris/godaddypy?icon=docker&label=image%20size)](https://hub.docker.com/r/trueosiris/godaddypy/) 
![Github stars](https://badgen.net/github/stars/trueosiris/docker-godaddypy?icon=github&label=stars) 
![Github forks](https://badgen.net/github/forks/trueosiris/docker-godaddypy?icon=github&label=forks) 
![Github issues](https://img.shields.io/github/issues/TrueOsiris/docker-godaddypy)
![Github last-commit](https://img.shields.io/github/last-commit/TrueOsiris/docker-godaddypy)

### environment variables

| Environment Variable | Key | Description |
| -------------------- | ---------------------------- | ------------------------------------------------------------------------------- |
| GODADDY_KEY | your_godaddy_key | godaddy api key |
| GODADDY_SECRET | your_godaddy_secret | godaddy api secret |
| DOMAINS | test.example.com,table.cloth.be | comma delimited list of domains to receive the A record |
| TZ | Europe/Brussels | timezone for ntpdate |

### links

github repo: https://github.com/TrueOsiris/docker-godaddypy <br>
dockerhub repo: https://hub.docker.com/repository/docker/trueosiris/godaddypy <br>

I'm using the following base repo, so credits go to this dev:<br>
https://github.com/eXamadeus/godaddypy

### log

Python script log arrives in /logdir/godaddy.log.<br>
The logdir folder can be defined as an external volume.
