

```
sudo docker build -t subsonic .
sudo docker run -d -p 8080:8080 -v $PWD/music:/var/music:ro -v $PWD/config:/var/subsonic:rw subsonic
```
