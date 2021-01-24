#!/usr/bin/env bash

echo you input $# arguments, and they are: $@

# use double bracket to avoid word splitting and pathname expansion
while [[ $1 != "" ]]; do
	echo "there're $# arguments left, the first one is $1"
	shift # use shift to remove last arguments
done

# use read to read user input
# -t wait time, -p prompt message, -a receive input as an array
read -p "What's your name and age? (input your name and age, separeted by blank space) >" name age
if [ $name ]; then
	greeting="Hi $name"
else
	greeting="Hi Stranger"
fi
if [ $age ] && (( $age < 40 )); then
	greeting="$greeting, young man"
fi
echo $greeting, nice to meet you!

# you can specify the Internal Field Separator by asign value for IFS
IFS="/" read -p "What's your favorite books? (input books seperated by \"/\") >" -a books
for book in "${books[@]}"; do
	echo $book
done


# exit and return 0 means result success, 1 means failure
exit 0
