library(glue)
library(fs)

setwd(file.path(Sys.getenv('PRODUCTOR_HOME'), 'nginx'))
NGINX_HOST_NAME <- Sys.getenv('NGINX_HOST_NAME')

nginx_conf <- glue('
events {}

http {
    
    upstream backend {
        server (NGINX_HOST_NAME):8000;
        server (NGINX_HOST_NAME):8001;
        server (NGINX_HOST_NAME):8002;
        server (NGINX_HOST_NAME):8003;
        server (NGINX_HOST_NAME):8004;
    }

    server {
        
        listen 80;

        location / {
            proxy_pass http://(NGINX_HOST_NAME):3000;
        }
        
        location /pgadmin {
            proxy_pass http://(NGINX_HOST_NAME):8081;
        }

        location /api/ {
            proxy_pass http://backend/;
        }

    }
}', .open='(', .close=')')


file.remove('nginx.conf')
write(nginx_conf, file = file.path(Sys.getenv('PRODUCTOR_HOME'), 'nginx', 'nginx.conf'))





