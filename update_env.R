
if (stringr::str_detect(getwd(), 'home')) {
  install.packages(c('fs', 'glue', 'devtools'))
  devtools::install_github("gregce/ipify") 
}


library(ipify)
library(fs)
library(glue)

PRODUCTOR_HOME=getwd()docker 
if (Sys.getenv('SERVER') == "") {
  SERVER = 'MISSING'
} else {
  SERVER = Sys.getenv('SERVER')
}

# local_ip <- tryCatch(expr = {
#   system("ifconfig en0 | grep inet | grep -v inet6 | awk '{print $2}'", intern = TRUE)
# }, finally = {
#   system("ifconfig enp1s0 | grep inet | grep -v inet6 | awk '{print $2}'", intern = TRUE)
# })

local_ip <- ipify::get_ip()

productor_conf <- glue(
"
SERVER={SERVER}
PRODUCTOR_HOME={PRODUCTOR_HOME}
NGINX_HOST_NAME=web
POSTGRES_HOST=productor_db
AIRFLOW_HOST={local_ip}
LOCALHOST_IP={local_ip}

# OPTIONAL
AIRFLOW__CORE__FERNET_KEY=lPWLoH65nZPnY6O-SrhlQsYBF1I2VuPx8NYTucdWpD4=%
AIRFLOW_USER=airflow
AIRFLOW_PASSWORD=airflow
AIRFLOW_DB=airflow

PRODUCTOR_POSTGRES_USER=admin
PRODUCTOR_POSTGRES_PASSWORD=password
PRODUCTOR_POSTGRES_DB=public
POSTGRES_PORT=5432

RSTUDIO_USER=admin
RSTUDIO_PW=password
"
)

write(productor_conf, file = file.path(PRODUCTOR_HOME, '.productor.conf'))

tryCatch(expr = {
  file_delete(path = '.env')
}, error = function(err) {
  message('.env does not exist')
})

tryCatch(expr = {
  file_delete(path = '.Renviron')
}, error = function(err) {
  message('.Renviron does not exist')
})

tryCatch(expr = {
  file_delete(path = 'nginx/nginx.conf')
}, error = function(err) {
  message('nginx/nginx.conf does not exist')
})

file_copy('.productor.conf', '.env', overwrite = TRUE)
file_copy('.productor.conf', '.Renviron', overwrite = TRUE)

readRenviron(".Renviron")

system('Rscript nginx.conf.R')

