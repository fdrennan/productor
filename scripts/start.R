library(fs)

setwd(Sys.getenv('PRODUCTOR_HOME'))

system('docker-compose -f airflow/docker-compose.yaml up -d --build productor_postgres')
system('docker-compose -f airflow/docker-compose.yaml up -d --build productor_initdb')

system('docker-compose -f postgres/docker-compose.yaml up --force-recreate -d')
system('docker-compose -f airflow/docker-compose.yaml up --force-recreate -d')
system('docker-compose -f plumber_api/docker-compose.yaml up --force-recreate -d')
system('docker-compose -f nginx/docker-compose.yaml up --force-recreate -d')
system('docker-compose -f shiny/docker-compose.yaml up --force-recreate -d')


