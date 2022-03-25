#!/bin/bash

clear

# -lt -le -eq -ge -gt -ne
str1="12" str2="123"
if [ $str1 -gt $str2 ]; then
	echo $str1 is greater than $str2
else
	echo $str1 is smaller than $str2
fi
echo


if [ ${#array[@]} == 3 ]; then
	echo length matches
else
	echo length does not match
fi
echo


i=`ls -l | wc -l`
case $i  in
	[0] )
		echo "there's no file"
		;;
	[1] )
		echo "there's only one file"
		;;
	[2-4] )
		echo "there're some files"
		;;
	* )
		echo "there're a lot of files"
		;;	
esac


