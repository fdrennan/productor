dirs_to_update <- c(
  'airflow',
  'glances',
  'nginx',
  'pgadmin',
  'postgres',
  'productor',
  'shiny'
)

for (dir in dirs_to_update) {
  file.copy('.env', file.path(dir, '.env'), overwrite = TRUE)
  file.copy('.env', file.path(dir, '.Renviron'), overwrite = TRUE)
}

file.copy('.env', '.Renviron', overwrite = TRUE)