library(fs)

tryCatch(expr = {
  setwd(Sys.getenv('PRODUCTOR_HOME'))
}, error = function(err) {
  message(as.character(err))
})

system('Rscript nginx.conf.R')

file_copy('.productor.conf', '.env', overwrite = TRUE)
file_copy('.productor.conf', '.Renviron', overwrite = TRUE)
