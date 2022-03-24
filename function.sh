!/bin/bash

clear

# an example of a function
function foo() {
	echo This is foo
}
foo

# another function example, you can omit the argument part
function print {
	echo $1 
}
print "Hello world!"

# third way to create a function
birth_year=1994
say() {
    age=$((`date +"%Y"` - $birth_year))
	# use $ and number to get arguemnts
	echo "Hi, my name is $1, and I'm $age years old."
}
say "Aaron Chen"

today() {
  echo "Today's date is: "
  date +"%A, %B %-d, %Y"
}
today
