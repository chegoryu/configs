server {
    server_name chprog.com, ~^(.*)\.chprog\.com$;

    if ($host = chprog.com) {
        return 301 $scheme://chegoryu.me$request_uri;
    }

    return 301 $scheme://$1.chegoryu.me$request_uri;

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
