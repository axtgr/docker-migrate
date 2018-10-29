# docker-migrate

A container that helps you copy your volumes from one Docker host to another using rsync over SSH.


## Usage

It can be run in two modes, _server_ (for hosting the volumes) and _client_ (for copying the volumes from the server). It uses three environment variables for configuration: `PASSWORD`, `HOST` and `PORT`. If a host is specified, it runs as a client to that host (and port), otherwise it runs as a server.

### Source host (server)

Set `PASSWORD` and run the container with volumes you want to copy mounted to `/volumes` and the container's port `22` bound to any host port. It will start a server waiting for client connections. You will have to manually stop the container after the procedure is finished.

Example source `docker-compose.yml`:

```yaml
...
migrate:
  image: ../docker-migrate
  ports:
    - "8722:22"
  environment:
    - PASSWORD: s3cR3t
  volumes:
    # Add :ro to make the volumes read-only just in case
    - some-data-volume:/volumes/some-data-volume:ro
...
```

### Destination host (client)

Set `PASSWORD`, `HOST` and `PORT` to the corresponding values of the source, then run the container with volumes mounted to the same directories. It will connect to the server using rsync over SSH and copy the contents of the volumes while displaying the progress. After completion the container will quit.

Example destination `docker-compose.yml`:

```yaml
...
migrate:
  image: ../docker-migrate
  environment:
    - PORT: 8722 # Source port, 8722 is default and can be omitted
    - HOST: 192.168.1.2 # Source host
    - PASSWORD: s3cR3t
  volumes:
    - some-data-volume:/volumes/some-data-volume
...
```


## License

[ISC](LICENSE)
