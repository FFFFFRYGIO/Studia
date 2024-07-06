#!/bin/bash
sum=0
for ((i=0; i<=$1; i=`expr $i + 5`)); do
    sum=`expr $sum + $i`
done
echo $sum