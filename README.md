# AeroSpike Docker

This is a simple Docker container for aerospike that allows you to easily run a single Aerospike instance
with no replication.
It has a basic configuration for a namespace "db" that is is set to ```/var/aerospike/aerospike.data```.
This file is configured to be mounted via a volume and is optimized for SSD drives (and we're running the SSD
backed engine for Aerospike).

## How to Build

Either run a build command like so:

```
sudo docker build --no-cache -t andrewcrosio/aerospike-docker:latest .
```

I recommend using ```--no-cache``` to prevent continuing on from steps that may have changed (at least during development).

Or use the make command:
`
```
make build
```

## How to Run

To run, simply create a directory where you want to keep the Aerospike logs and data and run like so:

```
sudo docker run --rm -v /var/aerospike:/var/aerospike andrewcrosio/aerospike-docker
```

Ensuring that the directory you are mounting the volume machine on the host actually exists.

Or use the Makefile command:

```
make run
```


