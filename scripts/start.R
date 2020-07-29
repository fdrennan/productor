installed_packages <- installed.packages()

if(!'fs' %in% installed_packages[,1]) {
  install.packages('fs', repos = "http://cran.us.r-project.org")
}

if(!'glue' %in% installed_packages[,1]) {
  install.packages('glue', repos = "http://cran.us.r-project.org")
}

library(fs)

tryCatch(
  setwd(Sys.getenv('PRODUCTOR_HOME')),
  error = function(err) {
    message('Already in PRODUCTOR_HOME')
  }
)
system('Rscript update_env.R')
system('docker-compose -f docker-compose.yaml up --force-recreate -d')


