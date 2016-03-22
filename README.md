```
$ eval "$(docker-machine env default)"

$ docker-machine start

$ docker-machine ip default

$ docker build -t snapshot .
```

Large instance:

```
$ docker run -it -p 4000:4000 --cpuset-cpus="0" --memory 1G snapshot
```

Small instance:

```
$ docker run -it -p 4000:4000 --cpuset-cpus="0" --memory 256M snapshot
```

```
# Delete all containers
docker rm -f $(docker ps -a -q)
# Delete all images
docker rmi -f $(docker images -q)
```

Run scraper locally

```
$ mix run --no-halt
```

For debugging use:

```
$ iex -S mix
```
