#!/bin/bash

str="hello world"
echo $str length is ${#str}
echo substring ${str:6:5} # from the sixth position substring 5 charactor
echo

echo ${str:-and}
echo ${null:-not_exist}
echo ${null:=set_value}
echo checking null value is $null
echo

val=`expr 2 \* 2` # + - * /, * need to be escaped, and you need to add ' ' between operators
echo "sum is $val"
echo "you can also use $(()) instead of expr, result = $((2 * 8))" 
echo

array=(val1 val2 val3)
echo ${array[0]} ${array[1]} ${array[2]}
echo "array length is ${#array[@]}"
echo

# -lt -le -eq -ge -gt -ne
str1="12" str2="123"
if [ $str1 -gt $str2 ]; then
	echo $str1 is greater than $str2 
else 
	echo $str1 is smaller than $str2
fi
echo

function say {
	echo $1
	echo second param is $2
}
say Aaron, hello world # call function
echo

if [ ${#array[@]} == 3 ]; then
	echo length matches
else
	echo length does not match
fi
echo

echo please input your name:
read input
case $input in
	Aaron)
		echo "Hello, Aaron" ;;
	Kevin)
		echo "Hello, Kevin" ;;
	*)
		echo "Sorry, I don't know who you are."
esac
echo


for (( i=1; i<10; i++ )); do 
	echo three expression loop: $i
done
echo

for i in 1 10 15 8 100; do
	echo in loop: $i
	if [ $i -eq 8 ]; then
	echo "find 8 in this list, quit now"
	break
	fi
done
echo

for i in {1..10}; do
	echo in loop with range: $i
done
echo

# -a or -e, file exists; -f, file exists and is not directory or other files; -d, file is a directory; 
# -s, file exists and is not empty;
# -w or -r, has write or read permission; -x, has execute permission;
if [ -a practice.sh ]; then
	echo practice.sh exists
fi 
echo

# use `` to wrap command or expressions
for file in `ls ./`; do
	echo $file info: `ls -al $file`
done
echo

