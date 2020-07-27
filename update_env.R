library(fs)

tryCatch(expr = {
  setwd(Sys.getenv('PRODUCTOR_HOME'))
}, error = function(err) {
  message(as.character(err))
})

dirs_to_update <- c(
  'airflow',
  'glances',
  'nginx',
  'postgres',
  'scripts',
  'productor',
  'plumber_api',
  'productorapp',
  'shiny'
)

system('Rscript nginx.conf.R')

tryCatch(expr = {
  setwd(Sys.getenv('PRODUCTOR_HOME'))
}, error = function(err) {
  message(as.character(err))
})

for (dir in dirs_to_update) {
  file_copy('.productor.conf', file.path(dir, '.env'), overwrite = TRUE)
  file_copy('.productor.conf', file.path(dir, '.Renviron'), overwrite = TRUE)
}

file_copy('.productor.conf', '.env', overwrite = TRUE)
file_copy('.productor.conf', '.Renviron', overwrite = TRUE)
