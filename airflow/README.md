cd airflow

docker-compose up -d --build postgres
docker-compose up -d --build initdb
docker-compose up 