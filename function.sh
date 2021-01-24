#!/bin/bash

clear

# an example of a function
function foo() {
	# do something here
}
foo

# another function example, you can omit the argument part
function print {
	echo $1 
}
print "Hello world!"

# third way to create a function
say() {
	# use $ and number to get arguemnts
	echo "Hi, my name is $1, and I'm $2 years old."
}
say "Aaron Chen" 26

today() {
  echo -n "Today's date is: "
  date +"%A, %B %-d, %Y"
}
today
