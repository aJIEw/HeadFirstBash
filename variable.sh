#!/bin/bash

clear

# define a variable
my_name="Aaron Chen"
echo "Hi I'm $my_name"

# you can also add big bracket around a variable
# so that interpreter knows where the end is
for type in Type Coffee Java; do
	echo "I know ${type}Script"
done

# you can use escape character in double quote
greeting="Nice to meet you, \"${my_name}\"!"
echo
echo $greeting
echo How are you doing?
