# PRODUCTOR 

## Getting Started 
1. Request permission from `fdrennan` in [NDEXR Slack](https://app.slack.com/client/TAS9MV5K2) for [RStudio](http://ndexr.com:8787) and Postgres access.
2. Get your own set of Reddit API credentials from [Reddit](https://ssl.reddit.com/prefs/apps/) 
2. `FORK` this repository to your Github account
3. Run `git clone https://github.com/YOUR_GITHUB_USERNAME/ndexr-platform.git`
4. RUN `git remote add upstream https://github.com/fdrennan/ndexr-platform.git`
4. RUN `cd ndexr-platform`
5. RUN `docker build -t redditorapi --file ./DockerfileApi .`
6. RUN `docker build -t rpy --file ./DockerfileRpy .`
7. RUN `docker build -t redditorapp --file ./DockerfileShiny .`


#### Once these steps are complete, contact me to see how to set your environment variables.
```
POSTGRES_USER=yournewusername
POSTGRES_PASSWORD=yourstrongpassword
POSTGRES_HOST=ndexr.com
POSTGRES_PORT=5433
POSTGRES_DB=postgres
REDDIT_CLIENT=yourclient
REDDIT_AUTH=yourauth
USER_AGENT="datagather by /u/username"
USERNAME=usernameforreddit
PASSWORD=passwordforreddit
```

## About the Dockerfiles
There are three dockerfiles that are needed: `DockerfileApi`, `DockerfileRpy`, and `DockerfileUi`

`DockerfileApi` is associated with the container needed to run an R [Plumber](https://www.rplumber.io/) API. 
In the container I take from [trestletech](https://hub.docker.com/r/trestletech/plumber/), I add on some additional 
Linux binaries and R packages. There are two R packages in this project. One is called [biggr] and the other is called 
[redditor], which are located in `./bigger` and `./redditor-api` respectively. To build the container, run the 
following:

```
docker build -t productor_api --file ./DockerfileApi .
```

`DockerfileRpy` is a container running both R and Python, This is taken from the `python:3.7.6` container. I install R 
on top of it, so I can run scheduled jobs. This container runs Airflow, which is set up in `airflower`. Original name, 
right? 

```
docker build -t productor_rpy --file ./DockerfileRpy .
```

This container contains code and packags required to run the Shiny application

```
docker build -t productor_app --file ./DockerfileShiny .
```

# Docker Files
```
docker build -t redditorapi --build-arg DUMMY={DUMMY} --file ./DockerfileApi .
docker build -t rpy --build-arg DUMMY={DUMMY} --file ./DockerfileRpy .
docker build -t redditorapp --build-arg DUMMY={DUMMY} --file ./DockerfileShiny .
```

# Delete a User
```.env
sudo userdel -r username
```