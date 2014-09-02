build_dev :
	sudo docker build -t andrewcrosio/aerospike-docker:latest .

build :
	sudo docker build --no-cache -t andrewcrosio/aerospike-docker:latest .

run :
	sudo docker run --rm -v /var/aerospike:/var/aerospike andrewcrosio/aerospike-docker
