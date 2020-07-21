library(fs)

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
  file_copy('.env', file.path(dir, '.env'), overwrite = TRUE)
  file_copy('.env', file.path(dir, '.Renviron'), overwrite = TRUE)
}

file_copy('.env', '.Renviron', overwrite = TRUE)