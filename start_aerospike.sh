#!/bin/bash
set -e

ASD=/usr/bin/asd
ASDN=$(basename $ASD)
PIDDIR=/var/run/aerospike
CONFIG_FILE=/etc/aerospike/aerospike.conf
OPTS="--config-file $CONFIG_FILE --foreground"
ASD_USER="aerospike"
ASD_GROUP=$ASD_USER

INITFNS=/etc/aerospike/initfns
if [ -f $INITFNS ]; then . $INITFNS; fi

test -x $ASD || exit 0

. /lib/lsb/init-functions

set_shmall() {
	mem=`/sbin/sysctl -n kernel.shmall`
	min=4294967296
	if [ "$mem" -lt $min ]
	then
		echo "kernel.shmall too low, setting to 4G pages"
		/sbin/sysctl -w kernel.shmall=$min
	fi
}

set_shmmax() {
	mem=`/sbin/sysctl -n kernel.shmmax`
	min=1073741824
	if [ "$mem" -lt $min ]
	then
		echo "kernel.shmmax too low, setting to 1GB"
		/sbin/sysctl -w kernel.shmmax=$min
	fi
}

#We are adding create_piddir as /var/run is tmpfs on ubuntu12.04. This causes
#the piddir to be removed on reboot
create_piddir() {
	if [ ! -d $PIDDIR ]
	then
		mkdir $PIDDIR
		chown $ASD_USER:$ASD_GROUP $PIDDIR
	fi
	}

echo "Starting Aerospike!"

set_shmall
set_shmmax
create_piddir

exec ${ASD} ${OPTS}
