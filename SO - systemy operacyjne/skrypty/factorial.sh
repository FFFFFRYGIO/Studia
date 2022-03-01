#!/bin/bash/
factorial()
{
	temp=$1
	value=1
	until [ $temp -eq 0 ]; do
		value=`expr $value \* $temp`
		temp=`expr $temp - 1`
	done
	echo Factorial of $1 is $value
}
echo Input parameter:
read parameter
factorial $parameter
