# docker-migrate

A container that helps you copy your volumes from one Docker host to another using rsync over SSH.

First you run this container on the source server to host the volumes, then run the container on the destination server to copy the volumes from the source.

### Source server

Set `PASSWORD` and run the container with volumes you want to copy mounted to `/volumes` and the container's port `22` bound to any host port. It will start a server waiting for client connections. You will have to manually stop the container after the procedure is finished.

Example source `docker-compose.yml`:

```yaml
...
migrate:
  build: ../docker-migrate
  ports:
    - "8722:22"
  environment:
    - PASSWORD=s3cR3t
  volumes:
    # Add :ro to make the volumes read-only just in case
    - some-data-volume:/volumes/some-data-volume:ro
...
```

### Destination server

Set `PASSWORD`, `HOST` and `PORT` variables to the corresponding values of the source, then run the container with volumes mounted to the same directories. It will connect to the server using rsync over SSH and copy the contents of the volumes while displaying the progress. After completion the container will quit.

Example destination `docker-compose.yml`:

```yaml
...
migrate:
  build: ../docker-migrate
  environment:
    - HOST=192.168.1.2 # Source host
    - PORT=8722 # Source port, 8722 is default and can be omitted    
    - PASSWORD=s3cR3t
  volumes:
    # No :ro here!
    - some-data-volume:/volumes/some-data-volume
...
```


## License

[ISC](LICENSE)
