# PRODUCTOR 

## Getting Started 


```
## Go to the working directory for productor
cd productor

## Build the API
docker build -t productor_api --file ./DockerfileApi .

## Build the Airflow Container
docker build -t productor_rpy --file ./DockerfileRpy .

## Build the Shiny Application
docker build -t productor_app --file ./DockerfileShiny .
```

```
POSTGRES_USER=yournewusername
POSTGRES_PASSWORD=yourstrongpassword
POSTGRES_HOST=ndexr.com
POSTGRES_PORT=5433
POSTGRES_DB=postgres

```

