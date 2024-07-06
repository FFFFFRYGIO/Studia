#!/bin/bash
sum=0
read num
while [[ $num -ge 0 && $num -le 100 ]]; do
    sum=`expr $sum + $num`
    read num
done
echo "Sum = $sum"