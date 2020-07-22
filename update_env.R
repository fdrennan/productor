library(fs)

setwd(Sys.getenv('PRODUCTOR_HOME'))

dirs_to_update <- c(
  'airflow',
  'glances',
  'nginx',
  'postgres',
  'scripts',
  'productor',
  'plumber_api',
  'shiny'
)

system('Rscript nginx/nginx.conf.R')

setwd(Sys.getenv('PRODUCTOR_HOME'))

for (dir in dirs_to_update) {
  file_copy('.productor.conf', file.path(dir, '.env'), overwrite = TRUE)
  file_copy('.productor.conf', file.path(dir, '.Renviron'), overwrite = TRUE)
}

file_copy('.productor.conf', '.env', overwrite = TRUE)
file_copy('.productor.conf', '.Renviron', overwrite = TRUE)
