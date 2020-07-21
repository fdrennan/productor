library(fs)

setwd(Sys.getenv('PRODUCTOR_HOME'))

system('docker build -t productor_api --file ./DockerfileApi .')
system('docker build -t productor_rpy --file ./DockerfileRpy .')
system('docker build -t productor_app --file ./DockerfileApp .')


