#!/bin/zsh

docker build -t productor_app_basis --file ./DockerfileApp .
#docker tag productor_app_basis:latest fdrennan/productor_app:latest
#docker push fdrennan/productor_app:latest


docker build -t productor_api_basis --file ./DockerfileApi .
#docker tag productor_api_basis:latest fdrennan/productor_api:latest
#docker push fdrennan/productor_api:latest


docker build -t productor_rpy_basis --file ./DockerfileRpy .
#docker tag productor_rpy_basis:latest fdrennan/productor_rpy:latest
#docker push fdrennan/productor_rpy:latest

docker-compose -f docker-compose-scratch.yaml up -d --build productor_postgres
docker-compose -f docker-compose-scratch.yaml up -d --build productor_initdb
docker-compose -f docker-compose-scratch.yaml down
docker-compose -f docker-compose-scratch.yaml up
