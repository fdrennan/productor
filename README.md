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
docker build -t productor_app --file ./DockerfileApp .
```

```
docker container ls -a
docker volume ls
```

## Build Airflow
```
cd airflow

docker-compose up -d --build productor_postgres
docker-compose up -d --build productor_initdb
docker-compose up 

```

## Build Postgres
```
cd postgres
docker-compose up 

```

## Build Shiny
```
cd postgres
docker-compose up 

```

### Remove Airflow 
```
docker container stop airflow_productor_scheduler_1
docker container stop airflow_productor_webserver_1
docker container stop airflow_productor_initdb_1
docker container stop airflow_productor_postgres_1
docker container rm airflow_productor_scheduler_1
docker container rm airflow_productor_webserver_1
docker container rm airflow_productor_initdb_1
docker container rm airflow_productor_postgres_1
docker volume rm airflow_productor-airflow-logs
docker volume rm airflow_productor_volume
docker volume rm airflow_airflow_postgres

```

### Remove Postgres
```
docker container stop productor_postgres
docker container rm productor_postgres
docker volume rm postgres_productor_postgres_volume

```

### Remove Shiny
```
docker container stop productor_app
docker container rm productor_app
docker volume rm postgres_productor_postgres_volume

```