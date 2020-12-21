#!/bin/bash

clear

# an example of a function
function foo() {
	echo bar
}
foo

# another function example, you can omit the argument part
function print {
	echo $1 
}
print "Hello world!"

# use $ and number to get arguemnts
function say {
	echo "Hi, my name is $1, and I'm $2 years old."
}
say "Aaron Chen" 26
