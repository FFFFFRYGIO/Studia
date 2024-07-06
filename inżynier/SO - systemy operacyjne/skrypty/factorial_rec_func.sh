#!/bin/bash
factorial()
{
	if [ $1 -eq 1 ]; then
		echo 1;
	else
		temp=`expr $1 - 1`
		temp2=$( factorial $temp )
		echo `expr $1 \* $temp2`
	fi
}
echo Input parameter:
read parameter
factorial $parameter