library(glue)
library(fs)

tryCatch(expr = {
    setwd(file.path(Sys.getenv('PRODUCTOR_HOME'), 'nginx'))
}, error = function(err) {
    message(as.character(err))
})

NGINX_HOST_NAME <- Sys.getenv('NGINX_HOST_NAME')
LOCALHOST_IP <- Sys.getenv('LOCALHOST_IP')

nginx_conf <- glue('
events {}

http {
    
    fastcgi_read_timeout 900;
    proxy_read_timeout 900;
    
    upstream backend {
        server (LOCALHOST_IP):8002;
        server (LOCALHOST_IP):8003;
        server (LOCALHOST_IP):8004;
        server (LOCALHOST_IP):8005;
        server (LOCALHOST_IP):8006;
    }

    server {
        
        listen 80;

        location / {
            proxy_pass http://shiny:3838;
        }
        

        location /api/ {
            proxy_pass http://backend/;
        }
        
        location /rstudio/ {
            proxy_pass http://(LOCALHOST_IP):8787;
        }

    }
}', .open='(', .close=')')


tryCatch(expr = {
    file.remove('nginx.conf')
}, error = function(err) {
    message(as.character(err))
})

write(nginx_conf, file = file.path(Sys.getenv('PRODUCTOR_HOME'), 'nginx', 'nginx.conf'))





