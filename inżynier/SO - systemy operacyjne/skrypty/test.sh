#!/bin/bash
echo $'\n'

echo Ex 1
echo $(whoami) -:- $HOME -:- $(date)
echo $'\n'

echo Ex 2
echo Input first number
read l1
echo Input second number
read l2
echo Input third number
read l3
sum=`expr $l1 + $l2 + $l3`
echo Sum equals $sum
diff=`expr $l1 - $l2 - $l3`
echo Difference equals $diff
product=`expr $l1 \* $l2 \* $l3`
echo Product equals $product
quotient=`expr $l1 / $l2 / $l3`
echo Quotient equals $quotient
echo $'\n'

echo Ex 3
echo Input path
read path
permissions=$( stat -c '%A' $path | cut -c 2-10 )
echo Permissions to object: $permissions
echo $'\n'

echo Ex 4
echo Input X
read X
echo Input Y
read Y
sum=0
XX=$X
for ((i=1; i<=Y; i++)) ; do
    XX=`expr $XX + $X`
    sum=`expr $sum + $XX`
done
echo sum of $Y following multiples of $X equals $sum
echo $'\n'
