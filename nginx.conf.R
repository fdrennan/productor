library(glue)
library(fs)

tryCatch(expr = {
    setwd(file.path(Sys.getenv('PRODUCTOR_HOME'), 'nginx'))
}, error = function(err) {
    message(as.character(err))
})

LOCALHOST_IP <- Sys.getenv('LOCALHOST_IP')

nginx_conf <- glue('
events {}

http {

    upstream backend {
        server (LOCALHOST_IP):8002;
        server (LOCALHOST_IP):8003;
        server (LOCALHOST_IP):8004;
        server (LOCALHOST_IP):8005;
        server (LOCALHOST_IP):8006;
    }

    server {
    
        proxy_set_header Host $http_host;
        
        listen 80;

        location / {
            proxy_pass http://(LOCALHOST_IP):3000;
        }
        

        location /api/ {
            proxy_pass http://backend/;
        }
        
        location /rstudio/ {
            proxy_pass http://(LOCALHOST_IP):8787;
        }

    }
}', .open='(', .close=')')


print(nginx_conf)

tryCatch(expr = {
    file.remove('nginx.conf')
}, error = function(err) {
    message('nginx.conf does not exist')
}, warning = function(warn) {
    message('Whatevs my dude')
})

write(nginx_conf, file = file.path(Sys.getenv('PRODUCTOR_HOME'), 'nginx', 'nginx.conf'))





