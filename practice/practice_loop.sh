#!/bin/bash

for (( i=1; i<5; i++ )); do
    echo for loop: $i
done
echo

for i in {1..5}; do
    echo for in loop with range: $i
done
echo

for i in 1 10 15 8 100; do
    echo current: $i
    if [ $i -eq 8 ]; then
        echo "find 8 in this list, quit loop now"
        break
    fi
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
select os in Ubuntu LinuxMint Windows8 Windows10 WindowsXP
do
  case $os in
    "Ubuntu"|"LinuxMint")
      echo "I also use $os."
    ;;
    "Windows8" | "Windows10" | "WindowsXP")
      echo "Why don't you try Linux?"
    ;;
    *)
      echo "Invalid entry."
      break
    ;;
  esac
done



