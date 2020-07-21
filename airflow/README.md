cd airflow

docker-compose up -d --build productor_postgres
docker-compose up -d --build productor_initdb
docker-compose up 