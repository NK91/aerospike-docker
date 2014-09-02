FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

RUN apt-get update && apt-get update --fix-missing
RUN apt-get upgrade -y
RUN apt-get dist-upgrade -y
RUN apt-get install -y wget nano python python-dev python-pip bcrypt

RUN wget http://www.aerospike.com/artifacts/aerospike-server-community/3.3.12/aerospike-server-community-3.3.12-ubuntu12.04.tgz
RUN tar -xzf aerospike-server-community-3.3.12-ubuntu12.04.tgz && rm aerospike-server-community-3.3.12-ubuntu12.04.tgz
RUN dpkg -i aerospike-server-community-3.3.12-ubuntu12.04/aerospike-server-community-3.3.12.ubuntu12.04.x86_64.deb
RUN dpkg -i aerospike-server-community-3.3.12-ubuntu12.04/aerospike-tools-3.3.13.ubuntu12.04.x86_64.deb
RUN rm -r aerospike-server-community-3.3.12-ubuntu12.04

ADD aerospike.conf /etc/aerospike/aerospike.conf
ADD start_aerospike.sh /

EXPOSE 3000
EXPOSE 3001
EXPOSE 3002
EXPOSE 3003

VOLUME ["/var/aerospike/"]

CMD ["/start_aerospike.sh"]
