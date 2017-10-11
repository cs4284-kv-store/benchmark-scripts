#! /bin/bash

for i in {1..10}
do
  file=$i.result
  for j in {1..19}
  do
    cmd="$HOME/bench/bench.sh sassafras $j"
    echo ${j},$($cmd | cut -d\" -f4) >> $file
  done
done
