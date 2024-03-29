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

num=1
if [[ "$num" =~ ^-?[0-9]+$ ]]; then
    echo "$num is an integer."
fi
echo

# -a or -e, file exists; -f, file exists and is not directory or other files; -d, file is a directory;
# -s, file exists and is not empty;
# -w or -r, has write or read permission; -x, has execute permission;
if [ -a practice.sh ]; then
    echo practice.sh exists
    echo
fi


i=`ls -l | wc -l`
case $i  in
    [0] )
        echo "there's no file"
        ;;
    [1] )
        echo "there's only one file"
        ;;
    [2-10] )
        echo "there're some files"
        ;;
    * )
        echo "there're a lot of files"
        ;;
esac


