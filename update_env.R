library(fs)

setwd(Sys.getenv('PRODUCTOR_HOME'))

dirs_to_update <- c(
  'airflow',
  'glances',
  'nginx',
  'pgadmin',
  'postgres',
  'productor',
  'plumber_api',
  'shiny'
)

for (dir in dirs_to_update) {
  file_copy('.productor.conf', file.path(dir, '.env'), overwrite = TRUE)
  file_copy('.productor.conf', file.path(dir, '.Renviron'), overwrite = TRUE)
}

file_copy('.productor.conf', '.env', overwrite = TRUE)
file_copy('.productor.conf', '.Renviron', overwrite = TRUE)

system('docker-compose -f airflow/docker-compose.yaml up --force-recreate -d')
system('docker-compose -f nginx/docker-compose.yaml up --force-recreate -d')
system('docker-compose -f plumber_api/docker-compose.yaml up --force-recreate -d')
system('docker-compose -f shiny/docker-compose.yaml up --force-recreate -d')
system('docker-compose -f postgres/docker-compose.yaml up --force-recreate -d')

# system('docker-compose -f airflow/docker-compose.yaml down')
# system('docker-compose -f nginx/docker-compose.yaml down')
# system('docker-compose -f plumber_api/docker-compose.yaml down')
# system('docker-compose -f shiny/docker-compose.yaml up down')
# system('docker-compose -f postgres/docker-compose.yaml up down')
