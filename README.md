

```
sudo docker build -t subsonic .
sudo docker run -d -p 127.0.0.1:8080:8080 -v $PWD/music:/var/music:ro -v $PWD/config:/var/subsonic:rw subsonic
```


```
upstream backend_server {
    server 127.0.0.1:8080;
}

server {
    listen       80;
    server_name  localhost;

    location / {
        proxy_pass http://backend_server;
        root /var/www/nginx-default;
        expires off;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header Connection "";
    }
}
```

