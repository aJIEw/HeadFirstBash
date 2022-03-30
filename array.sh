#!/bin/bash

clear

# create an array
array=(1 2 3)

# you can specify array items with index, the order doesn't matter
array=([2]="!" [0]="Hi" [1]="aJIEw")
echo ${array[0]} ${array[1]} ${array[2]}
echo

# or you can assign them one by one
array[0]="this"
array[1]="is"
array[2]="simple"
array[3]="right"
array[4]="?"


# use ${#array[@]} or ${array[*]}to get array length
length=${#array[@]}
echo array length is: $length
echo the last one in array is: ${array[length-1]}
echo another way of showing length: ${#array[*]}
echo

# get all the indices of this array
echo all the indices: "${!array[@]}"
echo

# get all the element through ${array[@]}
echo ${array[@]}
echo

array=([1]=Or [0]=Yes [2]=No)
for item in ${array[@]}; do
	echo -n "$item "
done
echo ; echo


# loop all the indices to get all elements
array=("the rose" "is red" "the violet" "is blue" "the honey" "is sweet") 
for index in ${!array[@]}; do
	if [ $(( index % 2  )) == 1 ]; then
		echo ${array[index]}
	else
		echo -n "${array[index]} "
	fi
done
echo ; echo


# sub array
echo the first two elements: ${array[@]:0:2}
echo sub array: ${array[@]:4}

# append to array
array+=(and so are you)
echo after appending: ${array[@]}

# delete from array
len=${#array[@]}
for ((  i = $[len-4] ; i < $len ; i++ )); do
    unset array[$i]
done;

echo after deletion: ${array[@]}
echo
