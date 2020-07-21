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

## Build the API
```
docker build -t productor_api --file ./DockerfileApi .
```

## Build the Airflow Container
```
docker build -t productor_rpy --file ./DockerfileRpy .
```

## Build the Shiny Application
```
docker build -t productor_app --file ./DockerfileShiny .
```
