#!/bin/bash

clear

echo "for loops:"
# for loop
for i in 1 2 3; do
    echo -n $i,
done
echo

# another way to use for loop
for (( i=0 ; i < 3 ; i++ )); do
    echo -n $i,
done
echo

# you can also use command as range source
for file in `ls ./`; do
    len=${#file}
    if [ ${file:len-3:3} == ".sh" ]; then
        echo $file is an executable shell script
    fi
done
echo


# while statement
echo "len=$len"
while [ $len -ge 5 ]; do
    echo "the len now is ${len}"
    ((len--))
done
echo

# until statement
until [ $len -ge 8 ]; do
    echo "$len: I'm in the until statement now"
    ((len++))
done
echo

# select statement
select language in Java Kotlin JavaScript Dart Python; do
    echo "Your favorite language is $language"
done

