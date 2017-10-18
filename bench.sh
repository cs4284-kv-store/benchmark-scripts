#! /bin/bash

master=$1
setters=$2

redis="redis-server redis.conf"
$redis > redis.out &

bench=redis-benchmark
setter_command="$bench -h ${master} -t set -l --csv -a guest"
getter_command="$bench -h ${master} -t get --csv -a guest"

for host in $(head -$setters host_list)
do
    ssh -o 'StrictHostKeyChecking no' $host $setter_command > ${host}.set.csv &
done

get_host=$(head -$(($setters + 1)) host_list | tail -1)
#echo running get on $get_host

ssh -o 'StrictHostKeyChecking no' $get_host $getter_command

#echo done with gets
#echo killing 

for host in $(head -$setters host_list)
do
    ssh -o 'StrictHostKeyChecking no' $host killall redis-benchmark
done

kill -9 $(cat redis.pid)
#echo killed
