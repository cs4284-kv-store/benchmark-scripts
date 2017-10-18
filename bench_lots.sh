#! /bin/bash

for i in {4..9}
do
  file=$i.result
  for j in {0..4}
  do
    cmd="./bench.sh $(hostname) $j"
    echo ${j},$($cmd | cut -d\" -f4) >> $file
  done
done
