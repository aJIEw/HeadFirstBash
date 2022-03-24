#!/bin/bash

clear

first='Hello'
second='World'
echo $first,$second

# when assigning a string, both " and ' can be used, the difference is you can
# use " to escape special characters, but ' will keep everything as it is

# use # to get string length
echo ${first} length is ${#first}
echo

${var:offset:length} # return the substring of var starting at offset and up to length characters
echo ${var:1:2}


# string substitution
var="pattern It's a great day, is't it? pattern"
echo $var
# if the pattern matches the beginning of the var, delete the shortest part that matches and return the rest
echo ${var#pattern} 
# if the pattern matches the beginning of the var, delete the longest part that matches and return the rest
echo ${var##pattern} 
# if the pattern matches the end of the var, delete the shortest part that matches and return the rest
echo ${var%pattern} 
# if the pattern matches the end of the var, delete the longest part that matches and return the rest
echo ${var%%pattern} 
# the longest match to pattern in var is replaced by string, only the first match is replaced
echo ${var/pattern/string} 
# the longest match to pattern in var is replaced by string, all matchs are replaced
echo ${var//pattern/string} 

