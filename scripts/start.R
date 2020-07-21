library(fs)

setwd(Sys.getenv('PRODUCTOR_HOME'))

system('docker-compose -f airflow/docker-compose.yaml up --force-recreate -d')
system('docker-compose -f nginx/docker-compose.yaml up --force-recreate -d')
system('docker-compose -f plumber_api/docker-compose.yaml up --force-recreate -d')
system('docker-compose -f shiny/docker-compose.yaml up --force-recreate -d')
system('docker-compose -f postgres/docker-compose.yaml up --force-recreate -d')

