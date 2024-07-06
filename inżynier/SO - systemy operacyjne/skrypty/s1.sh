#!/bin/bash
path=$1
result=./$path"_mod_"$2
case $2 in
    1) cat $path | tr "a-z" "A-Z" > $result;;
    2) cat $path | tr -d '\n' > $result;;
    3) head -3 $path | tail -1 > $result;;
    4) cat $path > $result;
        echo $'\nHi, i was here! Script2!'  >> $result;;
    *) echo "File not found!";;
esac