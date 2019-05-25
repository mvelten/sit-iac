#!/bin/bash

DATE=`date +%Y%m%d%H%M`
for DATABASE in `docker service ls --format "{{.Name}}"|grep database`

do 
	echo $DATABASE
	/opt/docker-tools/docker-exec.sh $DATABASE pg_dumpall -U gridware > /data/swarm/backup/${DATABASE}_${DATE}.sql
done
