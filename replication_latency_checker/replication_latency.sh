#!/bin/bash
# Sends alert if your replica server is behind with more than $allowed_delay minutes
# code: Viktor Nonov

allowed_delay=20
email="your@email.com"
psql_params="--cluster=9.6/main demo"

res=$(psql $psql_params -c 'select now() - pg_last_xact_replay_timestamp() as replication_delay, pg_is_in_recovery();' | grep "\-\-" -A 1 | tail -1)
delay=$(echo $res | awk '{print $1}')
in_recovery=$(echo $res | awk '{print $3}')

minutes=$(echo $delay | awk -F "[:.]" '{print $2}')
minutes_as_int=$(printf "%d" $minutes)
if [ $minutes_as_int -gt $allowed_delay ]
then
  echo 'yup, that sucks' | mail -s "Replica is behind with $delay" $email
fi

