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
echo


# ternary conditions
echo ${var:-ops} # if var exists and not null, return var, otherwise return ops
echo ${var:+ops} # if var exists and not null, return ops, otherwise return null (empty string)
echo ${var:=ops} # if var exists and not null, return var, otherwise set it to ops and return this value
echo ${var:?ops} # if var exists and not null, return var, otherwise print "var: ops" and break (exit 1, stderr)
echo

city=
echo ${city:?hangzhou}
