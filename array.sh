#!/bin/bash

clear

# create an array
array=(1 2 3)
# use ${#array[@]} to get array length
echo the last one in array is ${array[${#array[@]} - 1]}

# you can specify array items with index, the order doesn't matter
array=([2]="!" [0]="Hi" [1]="Aaron")
echo ${array[0]} ${array[1]} ${array[2]}

# or you can assign them one by one
array[0]="this"
array[1]="is"
array[2]="simple"
array[3]="right"
echo array length is ${#array[@]}

# read all elements
for item in "${array[@]}"; do
	echo -n $item
done
echo

# another way to get all elements
echo "${!array[@]}" # this will give you all the indices of this array
for index in ${!array[@]}; do
	echo -n ${array[index]}
done

# sub array
