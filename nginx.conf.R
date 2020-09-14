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
    autoindex on;
    autoindex_exact_size off;
    fastcgi_read_timeout 900;
    proxy_read_timeout 900;
    
    upstream backend {
        server api_one:8000;
        server api_two:8000;
        server api_three:8000;
        server api_four:8000;
        server api_five:8000;
    }

    server {
        
        listen 80;

        location /app {
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


print(nginx_conf)

tryCatch(expr = {
    file.remove('nginx.conf')
}, error = function(err) {
    message('nginx.conf does not exist')
}, warning = function(warn) {
    message('Whatevs my dude')
})

write(nginx_conf, file = file.path(Sys.getenv('PRODUCTOR_HOME'), 'nginx', 'nginx.conf'))





