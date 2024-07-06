#!/bin/bash
if [ $1 -eq 1 ]; then
	echo 1;
else
	temp=`expr $1 - 1`
	temp2=$( ./factorial_rec_script.sh $temp )
	echo `expr $1 \* $temp2`
fi