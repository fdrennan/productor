library(glue)
library(fs)

tryCatch(expr = {
    setwd(file.path(Sys.getenv('PRODUCTOR_HOME'), 'nginx'))
}, error = function(err) {
    message(as.character(err))
})

NGINX_HOST_NAME <- Sys.getenv('NGINX_HOST_NAME')

nginx_conf <- glue('
events {}

http {
    
    fastcgi_read_timeout 900;
    proxy_read_timeout 900;
    
    upstream backend {
        server redditapione:8000;
        server redditapitwo:8000;
        server redditapithree:8000;
        server redditapifour:8000;
        server redditapifive:8000;
    }

    server {
        
        listen 80;

        location / {
            proxy_pass http://shiny:3838;
        }
        

        location /api/ {
            proxy_pass http://backend/;
        }

    }
}', .open='(', .close=')')


tryCatch(expr = {
    file.remove('nginx.conf')
}, error = function(err) {
    message(as.character(err))
})

write(nginx_conf, file = file.path(Sys.getenv('PRODUCTOR_HOME'), 'nginx', 'nginx.conf'))





