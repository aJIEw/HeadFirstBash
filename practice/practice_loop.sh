#!/bin/bash

clear

echo for loop:
for (( i=1; i<5; i++ )); do
    echo -n  $i,
done
echo ; echo

echo for in loop with range:
for i in {1..5}; do
    echo -n $i,
done
echo ; echo

echo -n current:
for i in 1 10 15 8 100; do
    echo -n $i,
    if [ $i -eq 8 ]; then
        echo
        echo "find 8 in this list, quit loop now"
        break
    fi
done
echo

# use `` to wrap command or expressions
for file in `ls ./`; do
    echo $file info: `ls -al $file`
done
echo


count=0
while read line; do
    ((count++))
    if [[ -z $line ]]; then
        continue
    fi
    echo "Line $count contains $(echo -n $line | wc -c) characters: $line"
done < ~/.bash_profile


echo "Which Operating System do you like?"
select os in macOS Ubuntu LinuxMint Windows8 Windows10 WindowsXP
do
    case $os in
        "macOS")
            echo "I also use $os."
        ;;
        "Ubuntu" | "LinuxMint")
            echo "I like $os."
        ;;
        "Windows8" | "Windows10" | "WindowsXP")
            echo "OK."
        ;;
        *)
            echo "I don't know that os"
            break
        ;;
    esac
done



