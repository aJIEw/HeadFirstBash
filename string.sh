#!/bin/bash

clear

# when assigning a string, both " and ' can be used, the difference is you can
# use " to escape special characters, but ' will keep everything as it is
first=Hello
second='World'
echo $first, $second

# if you don't want expansion, you have to use ""
workspace="/Workspace"
echo $workspace


# ${#var} to get string length
str=Love
echo $str\'s length is ${#str}
echo

# return the substring of var starting at index until the end of string, unless length is specified
${var:index:length}
str="Love and Peace"
echo ${str:0}
echo ${str:9}
echo ${str:0:4}
echo


# string substitution
path=/home/root/workspace/dg.ajiew.me
echo original path: $path
# if the pattern matches the beginning of the path, delete the shortest part that matches and return the rest
echo after remove head dir: ${path#/*/}
# if the pattern matches the beginning of the path, delete the longest part that matches and return the rest
echo after remove parent dirs: ${path##*/}
echo

# if the pattern matches the end of the path, delete the shortest part that matches and return the rest
echo the parent dir: ${path%/*}
# if the pattern matches the end of the path, delete the longest part that matches and return the rest
echo after remove end: ${path%%.*}
echo

# the longest match to pattern in path is replaced by string, only the first match is replaced
echo another way to remove parent dirs: ${path/\/*\//}
# the longest match to pattern in path is replaced by string, all matchs are replaced
echo remove all dots: ${path//./}
echo

# match and replace (subsitution)
echo new dir name: ${path/#\/*\//\/etc/}
echo replace all dots with slashes: ${path//.//}

