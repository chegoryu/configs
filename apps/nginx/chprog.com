server {
    root /var/www/chprog.com/html;
    index index.html;

    server_name chprog.com, *.chprog.com;

    return 403;

    location / {
        try_files $uri $uri/ =404;
    }

    listen [::]:443 ssl ipv6only=on; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/chprog.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/chprog.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
    server_name www.chprog.com;
    return 301 $scheme://chprog.com$request_uri;

    listen [::]:443 ssl; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/chprog.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/chprog.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
    root /var/www/files.chprog.com/files;

    server_name files.chprog.com;

    location / {
        autoindex on;
        autoindex_format html;
    }

    listen [::]:443 ssl; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/chprog.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/chprog.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
    server_name reverse-proxy.chprog.com;

    location /junk/go/echo_server/ {
        proxy_pass http://127.0.0.1:9001/;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto https;
    }

    location / {
        return 404;
    }

    listen [::]:443 ssl; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/chprog.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/chprog.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
    listen 80;
    listen [::]:80;

    server_name chprog.com *.chprog.com;
    return 301 https://$host$request_uri;
}
