#!/bin/bash

clear

# simple for loop
for i in 1 2 3; do
	echo $i
done

# you can also use expression as range source
for file in `ls ./`; do
	len=${#file}
	if [ ${file:len-3:3} == ".sh" ]; then
		echo $file is an executable shell script
	fi
done
echo

# another way to use for loop
for (( i=0 ; i < 10 ; i++ )); do
	echo $i
done
echo


# while statement
while [ $len -ge 0 ]; do
	echo "the len now is ${len}"
	((len--))
done
echo

# until statement
until [ $len -ge 3 ]; do
	echo "I'm in the until statement now"
	((len++))
done
echo

