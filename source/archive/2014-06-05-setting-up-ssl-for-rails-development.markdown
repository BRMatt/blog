---
title: Setting up SSL for Rails development
date: 2014-06-05 00:00:00.000000000 00:00
meta:
  description: Basic SSL setup for Rail development using nginx for SSL termination.
  tags: ruby, rails, ror, ruby on rails, ssl, nginx, wildcard ssl, self-signed certificate, self-signed ssl, development
---

First things first, you need an SSL certificate.
Steps 1-4 of [this gist](https://gist.github.com/trcarden/3295935) cover how to generate
a self-signed certificate. If you want a wildcard certificate then use `*.domain` for the common name.

The easiest way to get SSL working with rails is have a local nginx instance that terminates
the SSL connection and then forwards the requests on to the app serverover http.
Some people say you can use thin/puma with SSL but after playing around with it for a few hours
it's more trouble than it's worth (and if you need http+https access you'll have to run
two servers, which isn't worth it).

The bare bones nginx config for an SSL server is as follows:

```
server {
    listen 443 ssl;
    server_name *.app.local;

    ssl on;
    ssl_certificate /etc/nginx/ssl/server.crt;
    ssl_certificate_key /etc/nginx/ssl/server.key;


    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_set_header Host $host:$server_port;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-Ssl on;
        proxy_set_header X-Forwarded-Proto https;
        proxy_set_header X-SSL 1;
    }
}
```

This assumes you've dumped the SSL certs you generated earlier into
`/etc/nginx/ssl`. If you're not using a wildcard SSL certificate then
remove the asterisk from `server_name`. 

The headers in the location block set are as follows:

* `Host $host:$server_port` - Unless you pass this header rails will try to use ssl over whatever port its server was started on
* `X-Real-IP $remote_addr` - Does what it says on the tin
* `X-Forwarded-Ssl` / `X-Forwarded-Proto https` / `X-SSL 1` - This will cause rails to use the https protocol on all URLs it generates
