#! /bin/bash

for host in $(head -$1 host_list)
do
  ssh $host killall redis-benchmark
done
